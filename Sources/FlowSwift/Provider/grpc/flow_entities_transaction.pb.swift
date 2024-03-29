// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: flow/entities/transaction.proto
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
private struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public enum Flow_Entities_TransactionStatus: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case unknown // = 0
  case pending // = 1
  case finalized // = 2
  case executed // = 3
  case sealed // = 4
  case expired // = 5
  case UNRECOGNIZED(Int)

  public init() {
    self = .unknown
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .unknown
    case 1: self = .pending
    case 2: self = .finalized
    case 3: self = .executed
    case 4: self = .sealed
    case 5: self = .expired
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .unknown: return 0
    case .pending: return 1
    case .finalized: return 2
    case .executed: return 3
    case .sealed: return 4
    case .expired: return 5
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Flow_Entities_TransactionStatus: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Flow_Entities_TransactionStatus] = [
    .unknown,
    .pending,
    .finalized,
    .executed,
    .sealed,
    .expired,
  ]
}

#endif  // swift(>=4.2)

public struct Flow_Entities_Transaction {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var script: Data = Data()

  public var arguments: [Data] = []

  public var referenceBlockID: Data = Data()

  public var gasLimit: UInt64 = 0

  public var proposalKey: Flow_Entities_Transaction.ProposalKey {
    get {return _proposalKey ?? Flow_Entities_Transaction.ProposalKey()}
    set {_proposalKey = newValue}
  }
  /// Returns true if `proposalKey` has been explicitly set.
  public var hasProposalKey: Bool {return self._proposalKey != nil}
  /// Clears the value of `proposalKey`. Subsequent reads from it will return its default value.
  public mutating func clearProposalKey() {self._proposalKey = nil}

  public var payer: Data = Data()

  public var authorizers: [Data] = []

  public var payloadSignatures: [Flow_Entities_Transaction.Signature] = []

  public var envelopeSignatures: [Flow_Entities_Transaction.Signature] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public struct ProposalKey {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var address: Data = Data()

    public var keyID: UInt32 = 0

    public var sequenceNumber: UInt64 = 0

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public struct Signature {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    public var address: Data = Data()

    public var keyID: UInt32 = 0

    public var signature: Data = Data()

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}

  private var _proposalKey: Flow_Entities_Transaction.ProposalKey? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Flow_Entities_TransactionStatus: @unchecked Sendable {}
extension Flow_Entities_Transaction: @unchecked Sendable {}
extension Flow_Entities_Transaction.ProposalKey: @unchecked Sendable {}
extension Flow_Entities_Transaction.Signature: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

private let _protobuf_package = "flow.entities"

extension Flow_Entities_TransactionStatus: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNKNOWN"),
    1: .same(proto: "PENDING"),
    2: .same(proto: "FINALIZED"),
    3: .same(proto: "EXECUTED"),
    4: .same(proto: "SEALED"),
    5: .same(proto: "EXPIRED"),
  ]
}

extension Flow_Entities_Transaction: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Transaction"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "script"),
    2: .same(proto: "arguments"),
    3: .standard(proto: "reference_block_id"),
    4: .standard(proto: "gas_limit"),
    5: .standard(proto: "proposal_key"),
    6: .same(proto: "payer"),
    7: .same(proto: "authorizers"),
    8: .standard(proto: "payload_signatures"),
    9: .standard(proto: "envelope_signatures"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.script) }()
      case 2: try { try decoder.decodeRepeatedBytesField(value: &self.arguments) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.referenceBlockID) }()
      case 4: try { try decoder.decodeSingularUInt64Field(value: &self.gasLimit) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._proposalKey) }()
      case 6: try { try decoder.decodeSingularBytesField(value: &self.payer) }()
      case 7: try { try decoder.decodeRepeatedBytesField(value: &self.authorizers) }()
      case 8: try { try decoder.decodeRepeatedMessageField(value: &self.payloadSignatures) }()
      case 9: try { try decoder.decodeRepeatedMessageField(value: &self.envelopeSignatures) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.script.isEmpty {
      try visitor.visitSingularBytesField(value: self.script, fieldNumber: 1)
    }
    if !self.arguments.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.arguments, fieldNumber: 2)
    }
    if !self.referenceBlockID.isEmpty {
      try visitor.visitSingularBytesField(value: self.referenceBlockID, fieldNumber: 3)
    }
    if self.gasLimit != 0 {
      try visitor.visitSingularUInt64Field(value: self.gasLimit, fieldNumber: 4)
    }
    try { if let v = self._proposalKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    if !self.payer.isEmpty {
      try visitor.visitSingularBytesField(value: self.payer, fieldNumber: 6)
    }
    if !self.authorizers.isEmpty {
      try visitor.visitRepeatedBytesField(value: self.authorizers, fieldNumber: 7)
    }
    if !self.payloadSignatures.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.payloadSignatures, fieldNumber: 8)
    }
    if !self.envelopeSignatures.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.envelopeSignatures, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Entities_Transaction, rhs: Flow_Entities_Transaction) -> Bool {
    if lhs.script != rhs.script {return false}
    if lhs.arguments != rhs.arguments {return false}
    if lhs.referenceBlockID != rhs.referenceBlockID {return false}
    if lhs.gasLimit != rhs.gasLimit {return false}
    if lhs._proposalKey != rhs._proposalKey {return false}
    if lhs.payer != rhs.payer {return false}
    if lhs.authorizers != rhs.authorizers {return false}
    if lhs.payloadSignatures != rhs.payloadSignatures {return false}
    if lhs.envelopeSignatures != rhs.envelopeSignatures {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Entities_Transaction.ProposalKey: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = Flow_Entities_Transaction.protoMessageName + ".ProposalKey"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "address"),
    2: .standard(proto: "key_id"),
    3: .standard(proto: "sequence_number"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.address) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self.keyID) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.sequenceNumber) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.address.isEmpty {
      try visitor.visitSingularBytesField(value: self.address, fieldNumber: 1)
    }
    if self.keyID != 0 {
      try visitor.visitSingularUInt32Field(value: self.keyID, fieldNumber: 2)
    }
    if self.sequenceNumber != 0 {
      try visitor.visitSingularUInt64Field(value: self.sequenceNumber, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Entities_Transaction.ProposalKey, rhs: Flow_Entities_Transaction.ProposalKey) -> Bool {
    if lhs.address != rhs.address {return false}
    if lhs.keyID != rhs.keyID {return false}
    if lhs.sequenceNumber != rhs.sequenceNumber {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Flow_Entities_Transaction.Signature: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = Flow_Entities_Transaction.protoMessageName + ".Signature"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "address"),
    2: .standard(proto: "key_id"),
    3: .same(proto: "signature"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.address) }()
      case 2: try { try decoder.decodeSingularUInt32Field(value: &self.keyID) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.signature) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.address.isEmpty {
      try visitor.visitSingularBytesField(value: self.address, fieldNumber: 1)
    }
    if self.keyID != 0 {
      try visitor.visitSingularUInt32Field(value: self.keyID, fieldNumber: 2)
    }
    if !self.signature.isEmpty {
      try visitor.visitSingularBytesField(value: self.signature, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Flow_Entities_Transaction.Signature, rhs: Flow_Entities_Transaction.Signature) -> Bool {
    if lhs.address != rhs.address {return false}
    if lhs.keyID != rhs.keyID {return false}
    if lhs.signature != rhs.signature {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
