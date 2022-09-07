//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/26.
//

import Foundation

public struct FlowTemplate {
    public enum FlowTemplateError: Error{
        case invalidTemplate
    }
    public enum FlowTemplateType: String{
        case createAccountTemplate = "CreateAccountTemplate"
        case transferTemplate = "TransferTemplate"
        case setupFusdVaultTemplate = "SetupFusdVaultTemplate"
        case getFusdBalanceTemplate = "GetFusdBalanceTemplate"
        case checkFusdVaultSetupTemplate = "CheckFusdVaultSetupTemplate"
        case addAccountKeyTemplate = "AddAccountKeyTemplate"
        case removeAccountKeyTemplate = "RemoveAccountKeyTemplate"
    }
    
    public static func content(type: FlowTemplateType) throws -> String{
        guard let templateUrl = Bundle.module.url(forResource: type.rawValue, withExtension: "txt") else {
            throw FlowTemplateError.invalidTemplate
        }
        return try "\n" + String(contentsOf: templateUrl, encoding: .utf8)
    }
}
