//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/2.
//

import Foundation

extension Data {
    /// Convert data to list of byte
    internal var bytes: Bytes {
        return Bytes(self)
    }

    /// Initial the data with hex string
    internal static func fromHex(_ hex: String) -> Data? {
        let string = hex.lowercased().stripHexPrefix()
        guard let array = string.data(using: .utf8)?.bytes else {
            return nil
        }
        if array.isEmpty {
            if hex == "0x" || hex == "" {
                return Data()
            } else {
                return nil
            }
        }
        return array.data
    }
    
    func fulfilZeroRight(maxSize: Int) -> Data {
        var bytes = self
        while bytes.count < maxSize {
            bytes.append(0)
        }
        return bytes
    }
}
