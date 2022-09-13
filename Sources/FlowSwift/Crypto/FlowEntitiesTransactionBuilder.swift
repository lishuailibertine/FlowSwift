//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/5.
//

import Foundation
import BigInt

public typealias FlowAddressData = Data

final public class FlowEntitiesTransactionBuilder{
    public enum FlowMessageType: String {
        case transaction = "FLOW-V0.0-transaction"
        case user = "FLOW-V0.0-user"
    }
    public var messageType: FlowMessageType = .transaction
    
    internal var transaction: Flow_Entities_Transaction = Flow_Entities_Transaction()
    internal var payloadSignatures = [FlowEntitiesTransactionSignature]()
    internal var envelopeSignatures = [FlowEntitiesTransactionSignature]()

    internal var signerMap: [Int: FlowAddressData]{
        var signers = [FlowAddressData]()
        //ProposalKey
        if transaction.proposalKey.address.count > 0 {
            signers.append(transaction.proposalKey.address)
        }
        //Payer
        if transaction.payer.count > 0 {
            signers.append(transaction.payer)
        }
        //authorizer
        transaction.authorizers.forEach{signers.append($0)}
        
        var signerMap = [Int: FlowAddressData]()
        for (index, signer) in signers.enumerated() {
            signerMap[index] = signer
        }
        return signerMap
    }
    
    internal var payloadData: [Any] {
        return [transaction.script,
                transaction.arguments,
                transaction.referenceBlockID,
                BigUInt(transaction.gasLimit),
                transaction.proposalKey.address,
                BigUInt(transaction.proposalKey.keyID),
                BigUInt(transaction.proposalKey.sequenceNumber),
                transaction.payer,
                transaction.authorizers]
    }
}
