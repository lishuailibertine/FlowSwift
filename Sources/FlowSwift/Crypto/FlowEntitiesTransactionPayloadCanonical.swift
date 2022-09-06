//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/5.
//

import Foundation

public struct FlowEnvelopeCanonicalForm {
    public var payload: [Any]
    public var payloadSignatures: [FlowEntitiesTransactionSignature]
    
    public var envelopePayload: [Any] {
        return [payload, payloadSignatures.compactMap{[$0.signerIndex, $0.keyIndex, $0.transactionSignature.signature]}]
    }
}
public struct FlowEntitiesTransactionSignature: Comparable {

    public var signerIndex: Int
    public var keyIndex: Int
    
    public var transactionSignature: Flow_Entities_Transaction.Signature
    
    public init(address: FlowAddress, signerIndex: Int, keyIndex: Int, signature: Data) {
        self.signerIndex = signerIndex
        self.keyIndex = keyIndex
        transactionSignature = Flow_Entities_Transaction.Signature.with{
            $0.signature = signature
            $0.address = address.addressData
            $0.keyID = UInt32(keyIndex)
        }
    }
    public static func < (lhs: FlowEntitiesTransactionSignature, rhs: FlowEntitiesTransactionSignature) -> Bool {
        if lhs.signerIndex == rhs.signerIndex {
            return lhs.keyIndex < rhs.keyIndex
        }
        return lhs.signerIndex < rhs.signerIndex
    }
    
}
