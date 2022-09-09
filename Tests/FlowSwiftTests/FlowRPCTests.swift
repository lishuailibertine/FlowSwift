//
//  FlowRPCTests.swift
//  
//
//  Created by li shuai on 2022/9/2.
//

import XCTest
import PromiseKit

@testable import FlowSwift
class FlowRPCTests: XCTestCase {

    var rpc: FlowGRPCRequest {
        return FlowGRPCRequest.shared
    }
   
    func test_getAccount() throws {
        
        let expectation = XCTestExpectation(description: #function)
        let key = try FlowECDSAP256Keypair(privateData: Data(hex: "af39ff9ad1db0c6df7c2e359f80ac95d71a82a4c03d3f169e98a81db00f9b717"))
        debugPrint("publicKey: \(key.publicData.toHexString())")
        rpc.queryAccount(address: "0xa2dcfc6200593335").done { account in
            debugPrint(account)
            account.account.keys.map { accountKey in
                debugPrint(accountKey.publicKey.toHexString())
            }
            expectation.fulfill()
        }.catch { error in
            debugPrint(error)
        }
        waitForExpectations(timeout: 10)
    }
}
