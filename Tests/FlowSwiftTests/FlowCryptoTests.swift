//
//  FlowCryptoTests.swift
//  
//
//  Created by li shuai on 2022/8/25.
//

import XCTest
import CryptoSwift

@testable import FlowSwift

class FlowCryptoTests: XCTestCase {

   
    func test_address() throws {
        let address = FlowAddress.generateAddress(chainCodeWord: .codeword_testnet)
        XCTAssert(FlowAddress.checkIntoAddress(chainCodeWord: .codeword_testnet, address: address))
    }

}
