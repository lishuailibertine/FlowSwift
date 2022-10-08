//
//  File.swift
//
//
//  Created by li shuai on 2022/9/16.
//

import Foundation
import CryptoSwift

public final class FlowKeyStore{
    public enum FlowKeystoreError: Error {
        case noEntropyError
        case keyDerivationError
        case aesError
        case invalidAccountError
        case invalidPasswordError
        case encryptionError(String)
    }
    public var keystoreParams: KeystoreParamsV3?
    
    public func UNSAFE_getPrivateKeyData(password: String) throws -> Data {
        guard let privateKey = try? self.getKeyData(password) else {
            throw FlowKeystoreError.invalidPasswordError
        }
        return privateKey
    }
    public convenience init?(_ jsonString: String) {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        self.init(jsonData)
    }

    public convenience init?(_ jsonData: Data) {
        guard let keystoreParams = try? JSONDecoder().decode(KeystoreParamsV3.self, from: jsonData) else {
            return nil
        }
        self.init(keystoreParams)
    }
    
    public init?(_ keystoreParams: KeystoreParamsV3) {
        if keystoreParams.version != 3 {
            return nil
        }
        if keystoreParams.crypto.version != nil && keystoreParams.crypto.version != "1" {
            return nil
        }
        self.keystoreParams = keystoreParams
    }
    
    public init?(privateKey: Data, password: String = "", aesMode: String = "aes-128-cbc") throws {
        guard privateKey.count == 32 else {
            return nil
        }
        try encryptDataToStorage(password, keyData: privateKey, aesMode: aesMode)
    }
    
    fileprivate func encryptDataToStorage(_ password: String, keyData: Data?, dkLen: Int = 32, N: Int = 4096, R: Int = 8, P: Int = 6, aesMode: String = "aes-128-cbc") throws {
        if keyData == nil {
            throw FlowKeystoreError.encryptionError("Encryption without key data")
        }
        let saltLen = 32
        guard let saltData = Data.randomBytes(length: saltLen) else {
            throw FlowKeystoreError.noEntropyError
        }
        guard let derivedKey = scrypt(password: password, salt: saltData, length: dkLen, N: N, R: R, P: P) else {
            throw FlowKeystoreError.keyDerivationError
        }
        let last16bytes = Data(derivedKey[(derivedKey.count - 16)...(derivedKey.count - 1)])
        let encryptionKey = Data(derivedKey[0...15])
        guard let IV = Data.randomBytes(length: 16) else {
            throw FlowKeystoreError.noEntropyError
        }
        var aesCipher: AES?
        switch aesMode {
        case "aes-128-cbc":
            aesCipher = try? AES(key: encryptionKey.bytes, blockMode: CBC(iv: IV.bytes), padding: .noPadding)
        case "aes-128-ctr":
            aesCipher = try? AES(key: encryptionKey.bytes, blockMode: CTR(iv: IV.bytes), padding: .noPadding)
        default:
            aesCipher = nil
        }
        if aesCipher == nil {
            throw FlowKeystoreError.aesError
        }
        guard let encryptedKey = try aesCipher?.encrypt(keyData!.bytes) else {
            throw FlowKeystoreError.aesError
        }
        let encryptedKeyData = Data(encryptedKey)
        var dataForMAC = Data()
        dataForMAC.append(last16bytes)
        dataForMAC.append(encryptedKeyData)
        let mac = dataForMAC.sha3(.keccak256)
        let kdfparams = KdfParamsV3(salt: saltData.toHexString(), dklen: dkLen, n: N, p: P, r: R, c: nil, prf: nil)
        let cipherparams = CipherParamsV3(iv: IV.toHexString())
        let crypto = CryptoParamsV3(ciphertext: encryptedKeyData.toHexString(), cipher: aesMode, cipherparams: cipherparams, kdf: "scrypt", kdfparams: kdfparams, mac: mac.toHexString(), version: nil)
        let keystoreparams = KeystoreParamsV3(crypto: crypto, id: UUID().uuidString.lowercased(), version: 3)
        self.keystoreParams = keystoreparams
    }
    
    fileprivate func getKeyData(_ password: String) throws -> Data? {
        guard let keystoreParams = self.keystoreParams else {
            return nil
        }
        let saltData = Data(hex: keystoreParams.crypto.kdfparams.salt)
        let derivedLen = keystoreParams.crypto.kdfparams.dklen
        var passwordDerivedKey: Data?
        switch keystoreParams.crypto.kdf {
        case "scrypt":
            guard let N = keystoreParams.crypto.kdfparams.n else {
                return nil
            }
            guard let P = keystoreParams.crypto.kdfparams.p else {
                return nil
            }
            guard let R = keystoreParams.crypto.kdfparams.r else {
                return nil
            }
            passwordDerivedKey = scrypt(password: password, salt: saltData, length: derivedLen, N: N, R: R, P: P)
        case "pbkdf2":
            guard let algo = keystoreParams.crypto.kdfparams.prf else {
                return nil
            }
            var hashVariant: HMAC.Variant?
            switch algo {
            case "hmac-sha256":
                hashVariant = HMAC.Variant.sha2(.sha256)
            case "hmac-sha384":
                hashVariant = HMAC.Variant.sha2(.sha256)
            case "hmac-sha512":
                hashVariant = HMAC.Variant.sha2(.sha256)
            default:
                hashVariant = nil
            }
            guard hashVariant != nil else {
                return nil
            }
            guard let c = keystoreParams.crypto.kdfparams.c else {
                return nil
            }
            guard let passData = password.data(using: .utf8) else {
                return nil
            }
            guard let derivedArray = try? PKCS5.PBKDF2(password: passData.bytes, salt: saltData.bytes, iterations: c, keyLength: derivedLen, variant: hashVariant!).calculate() else {
                return nil
            }
            passwordDerivedKey = Data(derivedArray)
        default:
            return nil
        }
        guard let derivedKey = passwordDerivedKey else {
            return nil
        }
        var dataForMAC = Data()
        let derivedKeyLast16bytes = Data(derivedKey[(derivedKey.count - 16)...(derivedKey.count - 1)])
        dataForMAC.append(derivedKeyLast16bytes)
        let cipherText = Data(hex: keystoreParams.crypto.ciphertext)
        if cipherText.count != 32 {
            return nil
        }
        dataForMAC.append(cipherText)
        let mac = dataForMAC.sha3(.keccak256)
        let calculatedMac = Data(hex: keystoreParams.crypto.mac)
        guard mac.constantTimeComparisonTo(calculatedMac) else {
            return nil
        }
        let cipher = keystoreParams.crypto.cipher
        let decryptionKey = derivedKey[0...15]
        let IV = Data(hex: keystoreParams.crypto.cipherparams.iv)
        var decryptedPK: Array<UInt8>?
        switch cipher {
        case "aes-128-ctr":
            guard let aesCipher = try? AES(key: decryptionKey.bytes, blockMode: CTR(iv: IV.bytes), padding: .noPadding) else {
                return nil
            }
            decryptedPK = try aesCipher.decrypt(cipherText.bytes)
        case "aes-128-cbc":
            guard let aesCipher = try? AES(key: decryptionKey.bytes, blockMode: CBC(iv: IV.bytes), padding: .noPadding) else {
                return nil
            }
            decryptedPK = try? aesCipher.decrypt(cipherText.bytes)
        default:
            return nil
        }
        guard decryptedPK != nil else {
            return nil
        }
        return Data(decryptedPK!)
    }

    public func serialize() throws -> Data? {
        guard let params = self.keystoreParams else {
            return nil
        }
        let data = try JSONEncoder().encode(params)
        return data
    }
    private func scrypt (password: String, salt: Data, length: Int, N: Int, R: Int, P: Int) -> Data? {
        guard let passwordData = password.data(using: .utf8) else {return nil}
        guard let deriver = try? Scrypt(password: passwordData.bytes, salt: salt.bytes, dkLen: length, N: N, r: R, p: P) else {return nil}
        guard let result = try? deriver.calculate() else {return nil}
        return Data(result)
    }
}
