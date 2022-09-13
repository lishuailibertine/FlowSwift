//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/13.
//

import Foundation

extension FlowEntitiesTransactionBuilder{
    @discardableResult
    public mutating func configScript(script: String) throws -> Self{
        guard let scriptData = script.data(using: .utf8) else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        transaction.script = scriptData
        return self
    }
    
    @discardableResult
    public mutating func configArguments(arguments: [Data] = []) throws -> Self{
        transaction.arguments = arguments
        return self
    }
    
    @discardableResult
    public mutating func configReferenceBlockID(referenceBlockID: Data = Data()) throws -> Self{
        transaction.referenceBlockID = referenceBlockID
        return self
    }
    
    @discardableResult
    public mutating func configProposalkey(address: Data, keyID: UInt32, sequenceNumber: UInt64) throws -> Self {
        transaction.proposalKey = Flow_Entities_Transaction.ProposalKey.with{
            $0.address = address
            $0.keyID = keyID
            $0.sequenceNumber = sequenceNumber
        }
        return self
    }
    
    @discardableResult
    public mutating func configPayer(payer: Data = Data()) throws -> Self{
        transaction.payer = payer
        return self
    }
    
    @discardableResult
    public mutating func configAuthorizers(auths: [FlowAddress]) throws -> Self {
        auths.forEach{transaction.authorizers.append($0.addressData)}
        return self
    }
    
    @discardableResult
    public mutating func configGasLimit(gasLimit: UInt64 = 0) throws -> Self {
        transaction.gasLimit = gasLimit
        return self
    }
    
}
