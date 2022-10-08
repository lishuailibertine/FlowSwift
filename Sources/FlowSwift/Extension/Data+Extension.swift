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

    /// Initial the data with  string
    internal static func fromString(_ str: String) -> Data? {
        let string = str.lowercased().stripHexPrefix()
        guard let array = string.data(using: .utf8)?.bytes else {
            return nil
        }
        if array.isEmpty {
            if str == "0x" || str == "" {
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
    static func randomBytes(length: Int) -> Data? {
        for _ in 0...1024 {
            var data = Data(repeating: 0, count: length)
            let result = data.withUnsafeMutableBytes { (body: UnsafeMutableRawBufferPointer) -> Int32? in
                if let bodyAddress = body.baseAddress, body.count > 0 {
                    let pointer = bodyAddress.assumingMemoryBound(to: UInt8.self)
                    return SecRandomCopyBytes(kSecRandomDefault, 32, pointer)
                } else {
                    return nil
                }
            }
            if let notNilResult = result, notNilResult == errSecSuccess {
                return data
            }
        }
        return nil
    }
    
    func constantTimeComparisonTo(_ other: Data?) -> Bool {
        guard let rhs = other else {return false}
        guard self.count == rhs.count else {return false}
        var difference = UInt8(0x00)
        for i in 0..<self.count { // compare full length
            difference |= self[i] ^ rhs[i] // constant time
        }
        return difference == UInt8(0x00)
    }
}
