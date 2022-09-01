//
//  FlowEncodeTests.swift
//  
//
//  Created by li shuai on 2022/8/26.
//

import XCTest

@testable import FlowSwift

public enum NJsonValueType: Encodable{
    
    case codeble(value: String)
    case codebleArray(values: [String])
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .codeble(let value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
            
        case .codebleArray(let values):
            var container = encoder.unkeyedContainer()
            for value in values {
                try container.encode(value)
            }
        }
    }
}

class FlowEncodeTests: XCTestCase {

    func test_encode() throws {
      // string
//        let str: JsonValueObject<String> = FlowEncode.prepareString(value: "11")
//        debugPrint(str)
//
//        // dic
//
//        let dicValue = ["1": "2"]
//        let empty: JsonValueObject<JsonDictionaryItem<String>> = FlowEncode.prepareDictionary(valueMap: dicValue)
//        let data = try JSONEncoder().encode(empty)
//        debugPrint(String(data: data, encoding: .utf8)!)
        
        let array: [Encodable] = [1, "1", FlowAddress(address: "")]
        
    }

}
