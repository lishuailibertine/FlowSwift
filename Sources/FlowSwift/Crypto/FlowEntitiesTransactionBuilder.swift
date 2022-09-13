//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/5.
//

import Foundation
import BigInt

public typealias FlowAddressData = Data

public struct FlowEntitiesTransactionBuilder{
    public enum FlowMessageType: String {
        case transaction = "FLOW-V0.0-transaction"
        case user = "FLOW-V0.0-user"
    }
    public var messageType: FlowMessageType = .transaction
    
    internal var transaction: Flow_Entities_Transaction = Flow_Entities_Transaction()
    internal var payloadSignatures: [FlowEntitiesTransactionSignature]
    internal var envelopeSignatures: [FlowEntitiesTransactionSignature]
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
