//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/6.
//

import Foundation

extension FlowEntitiesTransactionBuilder {
   //transfer
    public mutating func transfer(amount: String, toAddress: FlowAddress, authAddress: FlowAddress, payer: FlowAddress, gasLimit: UInt64) throws -> Flow_Entities_Transaction{
        guard let scriptData = try? FlowTemplate.content(type: .transferTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        
        guard let amountValueData = JsonCadenceObject(type: .uint64Type, value: .uInt64(UInt64(amount) ?? 0)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        guard let addressValueData = JsonCadenceObject(type: .addressType, value: .address(toAddress)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        let transferTransaction = Flow_Entities_Transaction.with{
            $0.script = scriptData
            $0.arguments = [amountValueData, addressValueData]
            $0.gasLimit = gasLimit
            $0.payer = payer.addressData
            $0.authorizers.append(authAddress.addressData)
        }
        return transferTransaction
    }
    
    // createAccount
    public mutating func createAccount(accountKeys: [Flow_Entities_AccountKey], contracts: [FlowContract], authAddress: FlowAddress, payer: FlowAddress, gasLimit: UInt64) throws -> Flow_Entities_Transaction {
        guard let scriptData = try? FlowTemplate.content(type: .createAccountTemplate).data(using: .utf8) else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        
        let publicKeyValue = accountKeys.compactMap { accountKey -> JsonCadenceObject? in
            guard let encodeData = RLP.encode(accountKey.accountKeyData) else{
                return nil
            }
            return JsonCadenceObject(type: .stringType, value: .string(encodeData.toHexString()))
        }
        guard let publicKeyData = JsonCadenceObject(type: .arrayType, value: .array(publicKeyValue)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        let contractValue = contracts.map { contract -> JsonDictionaryItem in
            return JsonDictionaryItem(key: JsonCadenceObject(type: .stringType, value: .string(contract.name)), value: JsonCadenceObject(type: .stringType, value: .string(contract.source)))
        }
       
        guard let contractData = JsonCadenceObject(type: .dictionaryType, value:.dictionary(contractValue)).jsonData() else {
            throw FlowTransactionError.buildTransferTransactionError
        }
        let transferTransaction = Flow_Entities_Transaction.with{
            $0.script = scriptData
            $0.arguments = [publicKeyData, contractData]
            $0.gasLimit = gasLimit
            $0.payer = payer.addressData
            $0.authorizers.append(authAddress.addressData)
        }
        return transferTransaction
    }
}
