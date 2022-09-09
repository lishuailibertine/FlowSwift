// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: flow/execution/execution.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct Flow_Execution_PingRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_PingResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_GetAccountAtBlockIDRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var blockID: Data = Data()

  public var address: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_GetAccountAtBlockIDResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var account: Flow_Entities_Account {
    get {return _account ?? Flow_Entities_Account()}
    set {_account = newValue}
  }
  /// Returns true if `account` has been explicitly set.
  public var hasAccount: Bool {return self._account != nil}
  /// Clears the value of `account`. Subsequent reads from it will return its default value.
  public mutating func clearAccount() {self._account = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _account: Flow_Entities_Account? = nil
}

public struct Flow_Execution_ExecuteScriptAtBlockIDRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var blockID: Data = Data()

  public var script: Data = Data()

  public var arguments: [Data] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_ExecuteScriptAtBlockIDResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var value: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_GetEventsForBlockIDsResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var results: [Flow_Execution_GetEventsForBlockIDsResponse.Result] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public struct Result {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var blockID: Data = Data()

    public var blockHeight: UInt64 = 0

    public var events: [Flow_Entities_Event] = []

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}
}

public struct Flow_Execution_GetEventsForBlockIDsRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var type: String = String()

  public var blockIds: [Data] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_GetTransactionResultRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var blockID: Data = Data()

  public var transactionID: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Flow_Execution_GetTransactionResultResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var statusCode: UInt32 = 0

  public var errorMessage: String = String()

  public var events: [Flow_Entities_Event] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Flow_Execution_PingRequest: @unchecked Sendable {}
extension Flow_Execution_PingResponse: @unchecked Sendable {}
extension Flow_Execution_GetAccountAtBlockIDRequest: @unchecked Sendable {}
extension Flow_Execution_GetAccountAtBlockIDResponse: @unchecked Sendable {}
extension Flow_Execution_ExecuteScriptAtBlockIDRequest: @unchecked Sendable {}
extension Flow_Execution_ExecuteScriptAtBlockIDResponse: @unchecked Sendable {}
extension Flow_Execution_GetEventsForBlockIDsResponse: @unchecked Sendable {}
extension Flow_Execution_GetEventsForBlockIDsResponse.Result: @unchecked Sendable {}
extension Flow_Execution_GetEventsForBlockIDsRequest: @unchecked Sendable {}
extension Flow_Execution_GetTransactionResultRequest: @unchecked Sendable {}
extension Flow_Execution_GetTransactionResultResponse: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "flow.execution"

extension Flow_Execution_PingRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PingRequest"
  public static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_PingRequest, rhs: Flow_Execution_PingRequest) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_PingResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".PingResponse"
  public static let _protobuf_nameMap = SwiftProtobuf._NameMap()

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let _ = try decoder.nextFieldNumber() {
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_PingResponse, rhs: Flow_Execution_PingResponse) -> Bool {
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetAccountAtBlockIDRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetAccountAtBlockIDRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .same(proto: "address"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.blockID) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.address) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.blockID, fieldNumber: 1)
    }
    if !self.address.isEmpty {
      try visitor.visitSingularBytesField(value: self.address, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetAccountAtBlockIDRequest, rhs: Flow_Execution_GetAccountAtBlockIDRequest) -> Bool {
    if lhs.blockID != rhs.blockID {return false}
    if lhs.address != rhs.address {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetAccountAtBlockIDResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetAccountAtBlockIDResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "account"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._account) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._account {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetAccountAtBlockIDResponse, rhs: Flow_Execution_GetAccountAtBlockIDResponse) -> Bool {
    if lhs._account != rhs._account {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_ExecuteScriptAtBlockIDRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ExecuteScriptAtBlockIDRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .same(proto: "script"),
    3: .same(proto: "arguments"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.blockID) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.script) }()
      case 3: try { try decoder.decodeRepeatedBytesField(value: &self.arguments) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.blockID, fieldNumber: 1)
    }
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 2)
    }
    if !self.arguments.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.arguments, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_ExecuteScriptAtBlockIDRequest, rhs: Flow_Execution_ExecuteScriptAtBlockIDRequest) -> Bool {
    if lhs.blockID != rhs.blockID {return false}
    if lhs.script != rhs.script {return false}
    if lhs.arguments != rhs.arguments {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_ExecuteScriptAtBlockIDResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ExecuteScriptAtBlockIDResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "value"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.value) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.value.isEmpty {
      try visitor.visitSingularBytesField(value: self.value, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_ExecuteScriptAtBlockIDResponse, rhs: Flow_Execution_ExecuteScriptAtBlockIDResponse) -> Bool {
    if lhs.value != rhs.value {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetEventsForBlockIDsResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetEventsForBlockIDsResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "results"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.results) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.results.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.results, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetEventsForBlockIDsResponse, rhs: Flow_Execution_GetEventsForBlockIDsResponse) -> Bool {
    if lhs.results != rhs.results {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetEventsForBlockIDsResponse.Result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = Flow_Execution_GetEventsForBlockIDsResponse.protoMessageName + ".Result"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .standard(proto: "block_height"),
    3: .same(proto: "events"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.blockID) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.blockHeight) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.events) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.blockID, fieldNumber: 1)
    }
    if self.blockHeight != 0 {
      try visitor.visitSingularUInt64Field(value: self.blockHeight, fieldNumber: 2)
    }
    if !self.events.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.events, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetEventsForBlockIDsResponse.Result, rhs: Flow_Execution_GetEventsForBlockIDsResponse.Result) -> Bool {
    if lhs.blockID != rhs.blockID {return false}
    if lhs.blockHeight != rhs.blockHeight {return false}
    if lhs.events != rhs.events {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetEventsForBlockIDsRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetEventsForBlockIDsRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "type"),
    2: .standard(proto: "block_ids"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.type) }()
      case 2: try { try decoder.decodeRepeatedBytesField(value: &self.blockIds) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 1)
    }
    if !self.blockIds.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.blockIds, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetEventsForBlockIDsRequest, rhs: Flow_Execution_GetEventsForBlockIDsRequest) -> Bool {
    if lhs.type != rhs.type {return false}
    if lhs.blockIds != rhs.blockIds {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetTransactionResultRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetTransactionResultRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "block_id"),
    2: .standard(proto: "transaction_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.blockID) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.transactionID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.blockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.blockID, fieldNumber: 1)
    }
    if !self.transactionID.isEmpty {
      try visitor.visitSingularBytesField(value: self.transactionID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetTransactionResultRequest, rhs: Flow_Execution_GetTransactionResultRequest) -> Bool {
    if lhs.blockID != rhs.blockID {return false}
    if lhs.transactionID != rhs.transactionID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Execution_GetTransactionResultResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".GetTransactionResultResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "status_code"),
    2: .standard(proto: "error_message"),
    3: .same(proto: "events"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularUInt32Field(value: &self.statusCode) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.errorMessage) }()
      case 3: try { try decoder.decodeRepeatedMessageField(value: &self.events) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.statusCode != 0 {
      try visitor.visitSingularUInt32Field(value: self.statusCode, fieldNumber: 1)
    }
    if !self.errorMessage.isEmpty {
      try visitor.visitSingularStringField(value: self.errorMessage, fieldNumber: 2)
    }
    if !self.events.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.events, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Execution_GetTransactionResultResponse, rhs: Flow_Execution_GetTransactionResultResponse) -> Bool {
    if lhs.statusCode != rhs.statusCode {return false}
    if lhs.errorMessage != rhs.errorMessage {return false}
    if lhs.events != rhs.events {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}