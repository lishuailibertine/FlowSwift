//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/24.
//

import Foundation
import SECP256r1
import Secp256k1Swift
import CryptoSwift

public enum FlowKeypairError: Error, LocalizedError {
    case invalidPrivateKey
    case signError
    case hashAlgorithmNotSupported
    case otherError(message: String)
    var rawValue: String {
        switch self {
        case .invalidPrivateKey:
            return "invalid PrivateKey"
        case .signError:
            return "sign Error"
        case .hashAlgorithmNotSupported:
            return "hash Algorithm Not Supported"
        case .otherError(let message):
                return message
        }
    }
    public var errorDescription: String? {
        return rawValue
    }
}
public protocol FlowKeypairInterface {
    var privateData: Data { get }
    var publicData: Data { get }
    init(privateData: Data) throws
    init() throws
    func sign(message: Data, hashingAlgorithm: FlowHashingAlgorithm) throws -> Data
    func signAlgorithm() -> FlowSigningAlgorithm
    static func isValidPrivateKey(privateData: Data) -> Bool
}

public struct FlowSecp256k1Keypair: FlowKeypairInterface {
    public var privateData: Data
    public var publicData: Data
    
    public init(privateData: Data) throws {
        self.privateData = privateData
        guard let publicKey = SECP256K1.privateToPublic(privateKey: privateData, compressed: false) else {
            throw FlowKeypairError.invalidPrivateKey
        }
        guard publicKey.count == 65 else {
            throw FlowKeypairError.invalidPrivateKey
        }
        self.publicData = publicKey.subdata(in: 1..<65)
    }
    
    public init() throws {
        guard let privateData = SECP256K1.generatePrivateKey() else {
            throw FlowKeypairError.invalidPrivateKey
        }
        try self.init(privateData: privateData)
    }
    
    public func sign(message: Data, hashingAlgorithm: FlowHashingAlgorithm) throws -> Data {
        guard let hashData = hashingAlgorithm.hashData(message: message) else {
            throw FlowKeypairError.hashAlgorithmNotSupported
        }
        let signedData = SECP256K1.signForRecovery(hash: hashData, privateKey: privateData)
        guard let signData = signedData.serializedSignature?.subdata(in: 0..<64) else {
            throw FlowKeypairError.signError
        }
        return signData
    }
    
    public func signAlgorithm() -> FlowSigningAlgorithm {
        return .ECDSASecp256k1
    }
    public static func isValidPrivateKey(privateData: Data) -> Bool {
        return  SECP256K1.verifyPrivateKey(privateKey: privateData)
    }
}

public struct FlowECDSAP256Keypair: FlowKeypairInterface {
    public var privateData: Data
    public var publicData: Data
    
    public init(privateData: Data) throws {
        self.privateData = privateData
        guard let curveCrypto = GMEllipticCurveCrypto(forKey: privateData) else {
            throw FlowKeypairError.invalidPrivateKey
        }
        guard curveCrypto.publicKey.count == 65 else {
            throw FlowKeypairError.invalidPrivateKey
        }
        self.publicData = curveCrypto.publicKey.subdata(in: 1..<65)
    }
    
    public init() throws {
        guard let curveCrypto = GMEllipticCurveCrypto.generateKeyPair(for: GMEllipticCurveSecp256r1) else {
            throw FlowKeypairError.invalidPrivateKey
        }
        self.privateData = curveCrypto.privateKey
        self.publicData = curveCrypto.publicKey.subdata(in: 1..<65)
    }
    
    public func sign(message: Data, hashingAlgorithm: FlowHashingAlgorithm) throws -> Data {
        guard let hashData = hashingAlgorithm.hashData(message: message) else {
            throw FlowKeypairError.hashAlgorithmNotSupported
        }
        guard let curveCrypto = GMEllipticCurveCrypto(forKey: privateData) else {
            throw FlowKeypairError.invalidPrivateKey
        }
        guard let signData = curveCrypto.signature(forHash: hashData) else {
            throw FlowKeypairError.signError
        }
        return signData
    }
    
    public func signAlgorithm() -> FlowSigningAlgorithm {
        return .ECDSAP256
    }
    public static func isValidPrivateKey(privateData: Data) -> Bool{
        guard let _ = try? FlowECDSAP256Keypair(privateData: privateData) else {
            return false
        }
        return true
    }
}
