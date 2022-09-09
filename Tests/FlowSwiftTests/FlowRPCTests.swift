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
        
//         rpc.queryAccount(address: "")
        
        test_error().done { hh in
            debugPrint(hh)
        }.catch { error in
            debugPrint(error)
        }
        expectation.fulfill()
        
    }
    
    func test_error() -> Promise<String> {
        return Promise { seal in
            throw NSError(domain: "", code: 2, userInfo: nil)
        }
    }
}
