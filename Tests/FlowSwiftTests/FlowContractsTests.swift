//
//  FlowContractsTests.swift
//  
//
//  Created by li shuai on 2022/8/25.
//

import XCTest
@testable import FlowSwift

class FlowContractsTests: XCTestCase {

    func test_loadContracts() throws {
        
        let settingsURL = Bundle.module.url(forResource: "AddAccountContractTemplate", withExtension: "txt")
        debugPrint(settingsURL)
    }
}
