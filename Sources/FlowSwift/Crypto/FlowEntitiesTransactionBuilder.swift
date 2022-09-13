//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/5.
//

import Foundation
import BigInt

public typealias FlowAddressData = Data

//signerList
extension Flow_Entities_Transaction{
    
    var signerMap: [Int: FlowAddressData]{
        var signers = [FlowAddressData]()
        //ProposalKey
        if proposalKey.address.count > 0 {
            signers.append(proposalKey.address)
        }
        //Payer
        if payer.count > 0 {
            signers.append(payer)
        }
        //authorizer
        authorizers.forEach{signers.append($0)}
        
        var signerMap = [Int: FlowAddressData]()
        for (index, signer) in signers.enumerated() {
            signerMap[index] = signer
        }
        return signerMap
    }
}
//PayloadCanonicalForm
extension Flow_Entities_Transaction{
    public var payloadData: [Any] {
        return [script,
                arguments,
                referenceBlockID,
                BigUInt(gasLimit),
                proposalKey.address,
                BigUInt(proposalKey.keyID),
                BigUInt(proposalKey.sequenceNumber),
                payer,
                authorizers]
    }
}
public struct FlowEntitiesTransactionBuilder{
    public enum FlowMessageType: String {
        case transaction = "FLOW-V0.0-transaction"
        case user = "FLOW-V0.0-user"
    }
    public var messageType: FlowMessageType = .transaction
    internal var transaction: Flow_Entities_Transaction = Flow_Entities_Transaction()
    
    private func prefixData() -> Data {
        guard let bytes = messageType.rawValue.data(using: .utf8) else {
            return Data()
        }
        return bytes.fulfilZeroRight(maxSize: 32)
    }
    private var payloadSignatures: [FlowEntitiesTransactionSignature]
    private var envelopeSignatures: [FlowEntitiesTransactionSignature]
   
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
