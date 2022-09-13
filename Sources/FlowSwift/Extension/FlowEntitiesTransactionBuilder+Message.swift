//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/6.
//

import Foundation

extension FlowEntitiesTransactionBuilder {
   //transfer
    @discardableResult
    public mutating func transfer(amount: String, toAddress: FlowAddress, auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64) throws -> FlowEntitiesTransactionBuilder{
        
        transaction.gasLimit = gasLimit
        transaction.payer = payer.addressData
        
        guard let scriptData = try? FlowTemplate.content(type: .transferTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        transaction.script = scriptData
        
        guard let amountValueData = JsonCadenceObject(type: .uint64Type, value: .uInt64(UInt64(amount) ?? 0)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        guard let addressValueData = JsonCadenceObject(type: .addressType, value: .address(toAddress)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        transaction.arguments = [amountValueData, addressValueData]
        auths.forEach{transaction.authorizers.append($0.addressData)}
        return self
    }
    
    
    // createAccount
    @discardableResult
    public mutating func createAccount(accountKeys: [Flow_Entities_AccountKey], contracts: [FlowContract], auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64) throws -> FlowEntitiesTransactionBuilder {
        
        transaction.gasLimit = gasLimit
        transaction.payer = payer.addressData
        
        guard let scriptData = try? FlowTemplate.content(type: .createAccountTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildCreateAccountTransactionError
        }
        transaction.script = scriptData
        
        let publicKeyValue = accountKeys.compactMap { accountKey -> JsonCadenceObject? in
            guard let encodeData = RLP.encode(accountKey.accountKeyData) else{
                return nil
            }
            return JsonCadenceObject(type: .stringType, value: .string(encodeData.toHexString()))
        }
        guard let publicKeyData = JsonCadenceObject(type: .arrayType, value: .array(publicKeyValue)).jsonData() else {
            throw FlowTransactionError.buildCreateAccountTransactionError
        }
        let contractValue = contracts.map { contract -> JsonDictionaryItem in
            return JsonDictionaryItem(key: JsonCadenceObject(type: .stringType, value: .string(contract.name)), value: JsonCadenceObject(type: .stringType, value: .string(contract.source)))
        }
       
        guard let contractData = JsonCadenceObject(type: .dictionaryType, value:.dictionary(contractValue)).jsonData() else {
            throw FlowTransactionError.buildCreateAccountTransactionError
        }
        transaction.arguments = [publicKeyData, contractData]
        auths.forEach{transaction.authorizers.append($0.addressData)}
        
        return self
    }
    
    // addAccountKey
    @discardableResult
    public mutating func addAccountKey(auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64, accountKey: Flow_Entities_AccountKey) throws -> FlowEntitiesTransactionBuilder{
        
        transaction.gasLimit = gasLimit
        transaction.payer = payer.addressData
        
        guard let scriptData = try? FlowTemplate.content(type: .addAccountKeyTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildAddAccountKeyTransactionError
        }
        transaction.script = scriptData
        
        guard let encodeStr = RLP.encode(accountKey.accountKeyData)?.toHexString() else{
            throw FlowTransactionError.buildAddAccountKeyTransactionError
        }
        guard let publicKeyData = JsonCadenceObject(type: .stringType, value: .string(encodeStr)).jsonData() else {
            throw FlowTransactionError.buildAddAccountKeyTransactionError
        }
        transaction.arguments = [publicKeyData]
        
        auths.forEach{transaction.authorizers.append($0.addressData)}
        return self
    }
    
    //removeAccountKey
    @discardableResult
    public mutating func removeAccountKey(auths: [FlowAddress], keyIndex: Int, payer: FlowAddress, gasLimit: UInt64) throws -> FlowEntitiesTransactionBuilder{
        
        transaction.gasLimit = gasLimit
        transaction.payer = payer.addressData
        
        guard let scriptData = try? FlowTemplate.content(type: .removeAccountKeyTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildRemoveAccountKeyTransactionError
        }
        transaction.script = scriptData
        
        guard let keyIndexData = JsonCadenceObject(type: .intType, value: .int(keyIndex)).jsonData() else {
            throw FlowTransactionError.buildRemoveAccountKeyTransactionError
        }
        transaction.arguments = [keyIndexData]
        auths.forEach{transaction.authorizers.append($0.addressData)}
        return self
    }
}
