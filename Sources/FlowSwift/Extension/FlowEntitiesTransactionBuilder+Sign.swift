//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/13.
//

import Foundation
extension FlowEntitiesTransactionBuilder{
    @discardableResult
    public mutating func  configSignPayload(address: FlowAddress, keyIndex: Int, signer: FlowKeypairInterface, hashingAlgorithm: FlowHashingAlgorithm) throws -> FlowEntitiesTransactionBuilder {
        guard let rlpData = RLP.encodeArray(transaction.payloadData) else {
            throw FlowTransactionError.rlpEncodeError
        }
        guard let signData = try? signer.sign(message: prefixData() + rlpData, hashingAlgorithm: hashingAlgorithm) else {
            throw FlowTransactionError.signPayloadError
        }
        addPayloadSignature(address: address, keyIndex: keyIndex, signData: signData)
        return self
    }
    
    @discardableResult
    public mutating func addPayloadSignature(address: FlowAddress, keyIndex: Int, signData: Data) -> FlowEntitiesTransactionBuilder{
        let signers = transaction.signerMap.filter {$0.value == address.addressData}
        let signerIndex = signers.first?.key ?? -1
        
        let transactionSignature = FlowEntitiesTransactionSignature(address: address, signerIndex: signerIndex, keyIndex: keyIndex, signature: signData)
        payloadSignatures.append(transactionSignature)
        payloadSignatures = payloadSignatures.sorted(by: <)
        refreshSignerIndex()
        return self
    }
    
    @discardableResult
    public mutating func  configSignEnvelope(address: FlowAddress, keyIndex: Int, signer: FlowKeypairInterface, hashingAlgorithm: FlowHashingAlgorithm) throws -> FlowEntitiesTransactionBuilder {
        guard let rlpData = RLP.encodeArray(FlowEnvelopeCanonicalForm(payload: transaction.payloadData, payloadSignatures: payloadSignatures).envelopePayload) else {
            throw FlowTransactionError.rlpEncodeError
        }
        guard let signData = try? signer.sign(message: prefixData() + rlpData, hashingAlgorithm: hashingAlgorithm) else {
            throw FlowTransactionError.signPayloadError
        }
        addEnvelopePayloadSignature(address: address, keyIndex: keyIndex, signData: signData)
        return self
    }
    
    @discardableResult
    public mutating func addEnvelopePayloadSignature(address: FlowAddress, keyIndex: Int, signData: Data) -> FlowEntitiesTransactionBuilder{
        let signers = transaction.signerMap.filter {$0.value == address.addressData}
        let signerIndex = signers.first?.key ?? -1
        let transactionSignature = FlowEntitiesTransactionSignature(address: address, signerIndex: signerIndex, keyIndex: keyIndex, signature: signData)
        envelopeSignatures.append(transactionSignature)
        envelopeSignatures = envelopeSignatures.sorted(by: <)
        refreshSignerIndex()
        return self
    }
    private func prefixData() -> Data {
        guard let bytes = messageType.rawValue.data(using: .utf8) else {
            return Data()
        }
        return bytes.fulfilZeroRight(maxSize: 32)
    }
    private mutating func refreshSignerIndex() {
        let signerMap = transaction.signerMap
        for (idx, obj) in payloadSignatures.enumerated() {
            let signers = signerMap.filter{$0.value == obj.transactionSignature.address}
            payloadSignatures[idx].signerIndex = signers.first?.key ?? -1
        }
        for (idx, obj) in envelopeSignatures.enumerated() {
            let signers = signerMap.filter{$0.value == obj.transactionSignature.address}
            envelopeSignatures[idx].signerIndex = signers.first?.key ?? -1
        }
    }
}