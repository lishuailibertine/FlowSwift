//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/16.
//

import Foundation

// Params
extension FlowKeyStore{
    public struct KdfParamsV3: Decodable, Encodable {
        var salt: String
        var dklen: Int
        var n: Int?
        var p: Int?
        var r: Int?
        var c: Int?
        var prf: String?
    }
    public struct CipherParamsV3: Decodable, Encodable {
        var iv: String
    }

    public struct CryptoParamsV3: Decodable, Encodable {
        var ciphertext: String
        var cipher: String
        var cipherparams: CipherParamsV3
        var kdf: String
        var kdfparams: KdfParamsV3
        var mac: String
        var version: String?
    }
    public struct KeystoreParamsV3: Codable {
        public var crypto: CryptoParamsV3
        public var id: String?
        public var version: Int
        public var isHDWallet: Bool?
        public var type: String?
        public init(crypto cr: CryptoParamsV3, id i: String, version ver: Int, type: String? = "private-key") {
            self.crypto = cr
            self.id = i
            self.version = ver
            self.type = type
        }
    }
}
