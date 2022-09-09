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
        
        let expectation = expectation(description: "testGRPC")
        let key = try FlowECDSAP256Keypair(privateData: Data(hex: "af39ff9ad1db0c6df7c2e359f80ac95d71a82a4c03d3f169e98a81db00f9b717"))
        rpc.queryAccount(address: "0xa2dcfc6200593335").done { account in
            let keys =  account.account.keys.filter{$0.publicKey == key.publicData}
            if keys.count > 0 {
                debugPrint("key be found: \(keys.first!.publicKey.toHexString())")
            }else{
                debugPrint("key not be found")
            }
            expectation.fulfill()
        }.catch { error in
            debugPrint(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
}
