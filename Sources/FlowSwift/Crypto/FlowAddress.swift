//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/24.
//

import Foundation
import CryptoSwift

//https://github.com/onflow/rosetta/blob/905dd965002b4fbe35d26031ba28f2f3fbedc30c/cmd/genaddress/genaddress.go

public struct FlowAddress: Codable {
    public typealias FlowAddressState = UInt64
    public static let zeroAddressState: FlowAddressState = 0
    public static let serviceAddressState: FlowAddressState = 1
    
    private static let linearCodeN: Int = 64
    private static let linearCodeK: Int = 45
    private static let linearCodeD: Int = 7
    
    private static let maxIndex: Int = (1 << linearCodeK) - 1
    private static let AddressLength: Int = (linearCodeN + 7) >> 3
    
    public let address: String
    public init?(address: String, chainCodeWord: FlowChainId = .codeword_mainnet) {
        guard FlowAddress.checkIntoAddress(chainCodeWord: chainCodeWord, address: address) else {
            return nil
        }
        self.address = address
    }
    public var addressData: Data {
        return Data(hex: self.address.stripHexPrefix())
    }
    static var parityCheckMatrixColumns: [UInt32] = [
        0x00001, 0x00002, 0x00004, 0x00008,
        0x00010, 0x00020, 0x00040, 0x00080,
        0x00100, 0x00200, 0x00400, 0x00800,
        0x01000, 0x02000, 0x04000, 0x08000,
        0x10000, 0x20000, 0x40000, 0x7328d,
        0x6689a, 0x6112f, 0x6084b, 0x433fd,
        0x42aab, 0x41951, 0x233ce, 0x22a81,
        0x21948, 0x1ef60, 0x1deca, 0x1c639,
        0x1bdd8, 0x1a535, 0x194ac, 0x18c46,
        0x1632b, 0x1529b, 0x14a43, 0x13184,
        0x12942, 0x118c1, 0x0f812, 0x0e027,
        0x0d00e, 0x0c83c, 0x0b01d, 0x0a831,
        0x0982b, 0x07034, 0x0682a, 0x05819,
        0x03807, 0x007d2, 0x00727, 0x0068e,
        0x0067c, 0x0059d, 0x004eb, 0x003b4,
        0x0036a, 0x002d9, 0x001c7, 0x0003f
    ]
    static var generatorMatrixRows: [UInt64] = [
        0xe467b9dd11fa00df, 0xf233dcee88fe0abe, 0xf919ee77447b7497, 0xfc8cf73ba23a260d,
        0xfe467b9dd11ee2a1, 0xff233dcee888d807, 0xff919ee774476ce6, 0x7fc8cf73ba231d10,
        0x3fe467b9dd11b183, 0x1ff233dcee8f96d6, 0x8ff919ee774757ba, 0x47fc8cf73ba2b331,
        0x23fe467b9dd27f6c, 0x11ff233dceee8e82, 0x88ff919ee775dd8f, 0x447fc8cf73b905e4,
        0xa23fe467b9de0d83, 0xd11ff233dce8d5a7, 0xe88ff919ee73c38a, 0x7447fc8cf73f171f,
        0xba23fe467b9dcb2b, 0xdd11ff233dcb0cb4, 0xee88ff919ee26c5d, 0x77447fc8cf775dd3,
        0x3ba23fe467b9b5a1, 0x9dd11ff233d9117a, 0xcee88ff919efa640, 0xe77447fc8cf3e297,
        0x73ba23fe467fabd2, 0xb9dd11ff233fb16c, 0xdcee88ff919adde7, 0xee77447fc8ceb196,
        0xf73ba23fe4621cd0, 0x7b9dd11ff2379ac3, 0x3dcee88ff91df46c, 0x9ee77447fc88e702,
        0xcf73ba23fe4131b6, 0x67b9dd11ff240f9a, 0x33dcee88ff90f9e0, 0x19ee77447fcff4e3,
        0x8cf73ba23fe64091, 0x467b9dd11ff115c7, 0x233dcee88ffdb735, 0x919ee77447fe2309,
        0xc8cf73ba23fdc736
    ]
    
    public static func checkIntoAddress(chainCodeWord: FlowChainId = .codeword_mainnet, address: String) -> Bool {
        let _address = address.hasPrefix("0x") ? address[2...] : address
        let addressData = Data(hex: _address)
        if addressData.count == AddressLength {
            let address_int64: UInt64 = getUInt64(bytes: addressData.bytes, startIndex: 0)
            return validateChainAddress(chainCodeWord: chainCodeWord, address: address_int64)
        }
        return false
    }
    
    public static func validateChainAddress(chainCodeWord: FlowChainId = .codeword_mainnet, address: UInt64) -> Bool {
        var codeWord = address ^ chainCodeWord.rawValue
        if codeWord == 0 {
            return false
        }
        var parity: UInt32 = 0
        for i in 0..<linearCodeN {
            if (codeWord & 1) == 1 {
                parity ^= parityCheckMatrixColumns[i]
            }
            codeWord >>= 1
        }
        return parity == 0
    }
    public static func generateAddress(chainCodeWord: FlowChainId = .codeword_mainnet) -> String {
        var index  = UInt64.random(in: 0...UInt64.max)
        var address: UInt64 = 0
        for i in 0..<linearCodeK {
            
            if (index & 1) == 1 {
                address ^= generatorMatrixRows[i]
            }
            index = index >> 1
        }
        let addressData = NSMutableData()
        address = address ^ chainCodeWord.rawValue
        putUInt64(address, to: addressData)
        return Data(bytes: addressData.mutableBytes, count: addressData.length).toHexString()
    }
}
