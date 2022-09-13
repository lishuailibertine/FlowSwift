//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/13.
//

import Foundation
extension FlowEntitiesTransactionBuilder{
    @discardableResult
    public func configSignPayload(address: FlowAddress, keyIndex: Int, signer: FlowKeypairInterface, hashingAlgorithm: FlowHashingAlgorithm) throws -> Self {
        guard let rlpData = RLP.encodeArray(payloadData) else {
            throw FlowTransactionError.rlpEncodeError
        }
        guard let signData = try? signer.sign(message: prefixData() + rlpData, hashingAlgorithm: hashingAlgorithm) else {
            throw FlowTransactionError.signPayloadError
        }
        addPayloadSignature(address: address, keyIndex: keyIndex, signData: signData)
        return self
    }
    
    @discardableResult
    public func addPayloadSignature(address: FlowAddress, keyIndex: Int, signData: Data) -> Self{
        let signers = signerMap.filter {$0.value == address.addressData}
        let signerIndex = signers.first?.key ?? -1
        
        let transactionSignature = FlowEntitiesTransactionSignature(address: address, signerIndex: signerIndex, keyIndex: keyIndex, signature: signData)
        payloadSignatures.append(transactionSignature)
        payloadSignatures = payloadSignatures.sorted(by: <)
        refreshSignerIndex()
        transaction.payloadSignatures = payloadSignatures.compactMap{$0.transactionSignature}
        return self
    }
    
    @discardableResult
    public func configSignEnvelope(address: FlowAddress, keyIndex: Int, signer: FlowKeypairInterface, hashingAlgorithm: FlowHashingAlgorithm) throws -> Self {
        guard let rlpData = RLP.encodeArray(FlowEnvelopeCanonicalForm(payload: payloadData, payloadSignatures: payloadSignatures).envelopePayload) else {
            throw FlowTransactionError.rlpEncodeError
        }
        guard let signData = try? signer.sign(message: prefixData() + rlpData, hashingAlgorithm: hashingAlgorithm) else {
            throw FlowTransactionError.signPayloadError
        }
        addEnvelopePayloadSignature(address: address, keyIndex: keyIndex, signData: signData)
        return self
    }
    
    @discardableResult
    public func addEnvelopePayloadSignature(address: FlowAddress, keyIndex: Int, signData: Data) -> Self{
        let signers = signerMap.filter {$0.value == address.addressData}
        let signerIndex = signers.first?.key ?? -1
        let transactionSignature = FlowEntitiesTransactionSignature(address: address, signerIndex: signerIndex, keyIndex: keyIndex, signature: signData)
        envelopeSignatures.append(transactionSignature)
        envelopeSignatures = envelopeSignatures.sorted(by: <)
        refreshSignerIndex()
        transaction.envelopeSignatures = envelopeSignatures.compactMap{$0.transactionSignature}
        return self
    }
    
    private func prefixData() -> Data {
        guard let bytes = messageType.rawValue.data(using: .utf8) else {
            return Data()
        }
        return bytes.fulfilZeroRight(maxSize: 32)
    }
    
    private func refreshSignerIndex() {
        let signerMap = signerMap
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
