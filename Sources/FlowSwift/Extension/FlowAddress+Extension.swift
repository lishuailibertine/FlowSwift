//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/25.
//

import Foundation

extension FlowAddress{
    static func getUInt32(bytes: [UInt8], startIndex: Int) -> UInt32 {
        let subBytes = bytes[startIndex..<startIndex + 4]
        let data = Data(subBytes)
        return UInt32(bigEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) })
    }
    
    static func getUInt64(bytes: [UInt8], startIndex: Int) -> UInt64 {
        let subBytes = bytes[startIndex..<startIndex+8]
        let data = Data(subBytes)
        return UInt64(bigEndian: data.withUnsafeBytes{ $0.load(as: UInt64.self)})
    }
    
    static func putUInt8(_ val: UInt8, to data: NSMutableData) {
        var value = val
        data.append(&value, length: 1)
    }
    
    static func putUInt32(_ val: UInt32, to data: NSMutableData) {
        var valBE = val.bigEndian
        data.append(&valBE, length: 4)
    }
    
    static func putUInt64(_ val: UInt64, to data: NSMutableData) {
        var valBE = val.bigEndian
        data.append(&valBE, length: 8)
    }
}
