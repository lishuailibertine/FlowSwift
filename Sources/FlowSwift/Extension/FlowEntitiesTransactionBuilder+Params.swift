//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/13.
//

import Foundation

extension FlowEntitiesTransactionBuilder{
    @discardableResult
    public mutating func configScript(script: String) throws -> FlowEntitiesTransactionBuilder{
        guard let scriptData = script.data(using: .utf8) else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        transaction.script = scriptData
        return self
    }
    
    @discardableResult
    public mutating func configArguments(arguments: [Data] = []) throws -> FlowEntitiesTransactionBuilder{
        transaction.arguments = arguments
        return self
    }
    
    @discardableResult
    public mutating func configReferenceBlockID(referenceBlockID: Data = Data()) throws -> FlowEntitiesTransactionBuilder{
        transaction.referenceBlockID = referenceBlockID
        return self
    }
    
    @discardableResult
    public mutating func configProposalkey(address: Data, keyID: UInt32, sequenceNumber: UInt64) throws -> FlowEntitiesTransactionBuilder {
        transaction.proposalKey = Flow_Entities_Transaction.ProposalKey.with{
            $0.address = address
            $0.keyID = keyID
            $0.sequenceNumber = sequenceNumber
        }
        return self
    }
    
    @discardableResult
    public mutating func configPayer(payer: Data = Data()) throws -> FlowEntitiesTransactionBuilder{
        transaction.payer = payer
        return self
    }
    
    @discardableResult
    public mutating func configAuthorizers(auths: [FlowAddress]) throws -> FlowEntitiesTransactionBuilder {
        auths.forEach{transaction.authorizers.append($0.addressData)}
        return self
    }
    
    @discardableResult
    public mutating func configGasLimit(gasLimit: UInt64 = 0) throws -> FlowEntitiesTransactionBuilder {
        transaction.gasLimit = gasLimit
        return self
    }
    
}
