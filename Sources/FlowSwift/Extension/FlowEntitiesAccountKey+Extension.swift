//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/7.
//

import Foundation
import BigInt

extension Flow_Entities_AccountKey {
    public var accountKeyData: [Any] {
        return [publicKey,
                BigUInt(signAlgo),
                BigUInt(hashAlgo),
                BigUInt(weight)]
    }
}
