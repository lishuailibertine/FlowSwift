//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/6.
//

import Foundation

extension FlowEntitiesTransactionBuilder {
    // transfer
    @discardableResult
    public func configTransfer(amount: String, toAddress: FlowAddress, auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64) throws -> Self{
        
        try configScript(script: FlowTemplate.content(type: .transferTemplate))
        guard let amountDecimal = Decimal(string:amount), let amountValueData = JsonCadenceObject(type: .ufix64Type, value: .uFix64(amountDecimal)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        guard let addressValueData = JsonCadenceObject(type: .addressType, value: .address(toAddress)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        try configPayer(payer: payer.addressData)
        try configArguments(arguments: [amountValueData, addressValueData])
        try configAuthorizers(auths: auths)
        try configGasLimit(gasLimit: gasLimit)
        return self
    }

    // createAccount
    @discardableResult
    public func configCreateAccount(accountKeys: [Flow_Entities_AccountKey], contracts: [FlowContract], auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64) throws -> Self {

        try configScript(script: FlowTemplate.content(type: .createAccountTemplate))
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
        guard let contractData = JsonCadenceObject(type: .dictionaryType, value: .dictionary(contractValue)).jsonData() else {
            throw FlowTransactionError.buildCreateAccountTransactionError
        }
        try configPayer(payer: payer.addressData)
        try configArguments(arguments: [publicKeyData, contractData])
        try configAuthorizers(auths: auths)
        try configGasLimit(gasLimit: gasLimit)
        return self
    }
    
    // addAccountKey
    @discardableResult
    public func configAddAccountKey(auths: [FlowAddress], payer: FlowAddress, gasLimit: UInt64, accountKey: Flow_Entities_AccountKey) throws -> Self{

        try configScript(script: FlowTemplate.content(type: .addAccountKeyTemplate))
        guard let encodeStr = RLP.encode(accountKey.accountKeyData)?.toHexString() else{
            throw FlowTransactionError.buildAddAccountKeyTransactionError
        }
        guard let publicKeyData = JsonCadenceObject(type: .stringType, value: .string(encodeStr)).jsonData() else {
            throw FlowTransactionError.buildAddAccountKeyTransactionError
        }
        try configPayer(payer: payer.addressData)
        try configArguments(arguments: [publicKeyData])
        try configAuthorizers(auths: auths)
        try configGasLimit(gasLimit: gasLimit)
        return self
    }
    
    // removeAccountKey
    @discardableResult
    public func configRemoveAccountKey(auths: [FlowAddress], keyIndex: Int, payer: FlowAddress, gasLimit: UInt64) throws -> Self{
        
        try configScript(script: FlowTemplate.content(type: .removeAccountKeyTemplate))
        guard let keyIndexData = JsonCadenceObject(type: .intType, value: .int(keyIndex)).jsonData() else {
            throw FlowTransactionError.buildRemoveAccountKeyTransactionError
        }
        try configPayer(payer: payer.addressData)
        try configArguments(arguments: [keyIndexData])
        try configAuthorizers(auths: auths)
        try configGasLimit(gasLimit: gasLimit)
        return self
    }
}
