//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/31.
//

import Foundation

public struct JsonDictionaryItem: Encodable{
    public let key: JsonCadenceObject
    public let value: JsonCadenceObject
}
public struct JsonCompositeValue: Encodable{
    public struct JsonCompositeField: Encodable{
        public let name: String
        public let value: JsonCadenceObject
    }
    public let id: String
    public let fields: [JsonCompositeField]
}

public struct JsonLinkValue: Encodable{
    public let targetPath: JsonCadenceObject
    public let borrowType: String
}

public struct JsonPathValue: Encodable{
    public let domain: String
    public let identifier: String
}

public struct JsonTypeValue: Encodable{
    public let staticType: String
}

public struct JsonCapabilityValue: Encodable{
    public let path: String
    public let address: String
    public let borrowType: String
}
