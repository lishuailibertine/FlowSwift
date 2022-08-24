//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/24.
//

import Foundation
import CryptoSwift

public enum FlowSigningAlgorithm: Int {
    case UnknownSigningAlgorithm = 0
    case BLSBLS12381 = 1
    case ECDSAP256 = 2
    case ECDSASecp256k1 = 3
}

public enum FlowHashingAlgorithm: Int {
    
    case UnknownHashingAlgorithm = 0
    case SHA2_256 = 1
    case SHA2_384 = 2
    case SHA3_256 = 3
    case SHA3_384 = 4
    
    public func hashData(message: Data) -> Data?{
        switch self{
        case .SHA2_256:
            return message.sha256()
        case .SHA2_384:
            return message.sha384()
        case .SHA3_256:
            return message.sha3(.sha256)
        case .SHA3_384:
            return message.sha3(.sha384)
        default:
            return nil
        }
    }
}
