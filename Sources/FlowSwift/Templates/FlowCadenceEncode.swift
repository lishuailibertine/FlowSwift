//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/26.
//

import Foundation
import BigInt

// https://developers.flow.com/cadence/json-cadence-spec#type

public struct JsonCadenceObject: Encodable{
    public enum FlowContractsMetaType: String, Encodable{
        case voidType = "Void"
        case optionalType = "Optional"
        case boolType = "Bool"
        case stringType = "String"
        case addressType = "Address"
        case intType = "Int"
        case int8Type = "Int8"
        case int16Type = "Int16"
        case int32Type = "Int32"
        case int64Type = "Int64"
        case int128Type = "Int128"
        case int256Type = "Int256"
        case uintType = "UInt"
        case uint8Type = "UInt8"
        case uint16Type = "UInt16"
        case uint32Type = "UInt32"
        case uint64Type = "UInt64"
        case uint128Type = "UInt128"
        case uint256Type = "UInt256"
        case word8Type = "Word8"
        case word16Type = "Word16"
        case word32Type = "Word32"
        case word64Type = "Word64"
        case fix64Type = "Fix64"
        case ufix64Type = "UFix64"
        case arrayType = "Array"
        case dictionaryType = "Dictionary"
        case structType = "Struct"
        case resourceType = "Resource"
        case eventType = "Event"
        case contractType = "Contract"
        case linkType = "Link"
        case pathType = "Path"
        case type = "Type"
        case capabilityType = "Capability"
        case enumType = "Enum"
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        }
    }
    public indirect enum JsonValueObject {
        case void
        case optional(value: JsonCadenceObject?)
        case bool(Bool)
        case string(String)
        case address(FlowAddress)
        case int(Int)
        case int8(Int8)
        case int16(Int16)
        case int32(Int32)
        case int64(Int64)
        case int128(BigInt)
        case int256(BigInt)
        case uInt(UInt)
        case uInt8(UInt8)
        case uInt16(UInt16)
        case uInt32(UInt32)
        case uInt64(UInt64)
        case uInt128(BigInt)
        case uInt256(BigInt)
        case word8(BigInt)
        case word16(BigInt)
        case word32(BigInt)
        case word64(BigInt)
        case fix64(Double)
        case uFix64(Double)
        case array([JsonCadenceObject])
        case dictionary(JsonDictionaryItem)
        case `struct`(JsonCompositeValue)
        case resource(JsonCompositeValue)
        case event(JsonCompositeValue)
        case contract(JsonCompositeValue)
        case link(JsonLinkValue)
        case path(JsonPathValue)
        case type(JsonTypeValue)
        case capability(JsonCapabilityValue)
        case `enum`(JsonCompositeValue)
    }
    public let type: FlowContractsMetaType
    public let value: JsonValueObject
}

extension JsonCadenceObject.JsonValueObject: Encodable{
    static let Fix64Factor = 100000000
    static let Fix64Scale = 8
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self{
        case .void:
            try container.encodeNil()
        case .optional(let value):
            try container.encode(value)
        case .bool(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .address(let flowaddress):
            try container.encode(flowaddress.address)
        case .int(let value):
            try container.encode(value)
        case .int8(let value):
            try container.encode(value)
        case .int16(let value):
            try container.encode(value)
        case .int32(let value):
            try container.encode(value)
        case .int64(let value):
            try container.encode(value)
        case .int128(let value):
            try container.encode(value.description)
        case .int256(let value):
            try container.encode(value.description)
        case .uInt(let value):
            try container.encode(value)
        case .uInt8(let value):
            try container.encode(value)
        case .uInt16(let value):
            try container.encode(value)
        case .uInt32(let value):
            try container.encode(value)
        case .uInt64(let value):
            try container.encode(value)
        case .uInt128(let value):
            try container.encode(value.description)
        case .uInt256(let value):
            try container.encode(value.description)
        case .word8(let value):
            try container.encode(value.description)
        case .word16(let value):
            try container.encode(value.description)
        case .word32(let value):
            try container.encode(value.description)
        case .word64(let value):
            try container.encode(value.description)
        case .fix64(let value):
            try container.encode(String(value))
        case .uFix64(let value):
            try container.encode(String(value))
        case .array(let array):
            try container.encode(array)
        case .dictionary(let dic):
            try container.encode(dic)
        case .struct(let value):
            try container.encode(value)
        case .resource(let value):
            try container.encode(value)
        case .event(let value):
            try container.encode(value)
        case .contract(let value):
            try container.encode(value)
        case .link(let value):
            try container.encode(value)
        case .path(let vallue):
            try container.encode(vallue)
        case .type(let value):
            try container.encode(value)
        case .capability(let value):
            try container.encode(value)
        case .enum(let value):
            try container.encode(value)
        }
    }
}
