//
//  File.swift
//  
//
//  Created by li shuai on 2022/9/6.
//

import Foundation

public enum FlowTransactionError: Error, LocalizedError {
    case signPayloadError
    case signEnvelopeError
    case rlpEncodeError
    case buildTransferTransactionError
    case buildCreateAccountTransactionError
    case buildAddAccountKeyTransactionError
    case buildRemoveAccountKeyTransactionError
}
