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

    let rpc: FlowGRPCRequest = FlowGRPCRequest.shared
   
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
    
    func test_getBlock() throws {
        
        let expectation = expectation(description: "testGRPC")
        rpc.queryBlock().done { block in
            
            expectation.fulfill()
        }.catch { error in
            debugPrint(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    //测试时把主网的合约地址修改为测试网
    func test_sendTransaction() throws {
        let expectation = expectation(description: "test_sendTransaction")
        let key = try FlowECDSAP256Keypair(privateData: Data(hex: "af39ff9ad1db0c6df7c2e359f80ac95d71a82a4c03d3f169e98a81db00f9b717"))
        let fromAddress = FlowAddress(address: "0xa2dcfc6200593335", chainCodeWord: .codeword_testnet)!
        let toAddress = FlowAddress(address: "0x025aa094fc7cca30", chainCodeWord: .codeword_testnet)!
        let amount = "1"
        firstly {
            when(fulfilled: rpc.queryAccount(address: fromAddress.address),
                 rpc.queryLatestBlock(sealed: true))
        }.then { (accountResponse, blockResponse) -> Promise<Data> in
            let accountkeys =  accountResponse.account.keys.filter{$0.publicKey == key.publicData}
            guard let accountKey = accountkeys.first else {
                throw FlowTransactionError.buildTransferTransactionError
            }
            let buildTransaction = try FlowEntitiesTransactionBuilder()
                .configTransfer(amount: amount, toAddress: toAddress, auths: [fromAddress], payer: fromAddress, gasLimit: 300)
                .configProposalkey(address: fromAddress.addressData, keyID: accountKey.index, sequenceNumber: UInt64(accountKey.sequenceNumber))
                .configReferenceBlockID(referenceBlockID: blockResponse.block.id)
                .signEnvelope(address: fromAddress, keyIndex: Int(accountKey.index), signer: key, hashingAlgorithm: .SHA3_256)
         
            return Promise{ seal in
                self.rpc.sendTransaction(builder: buildTransaction).done { response in
                    seal.fulfill(response.id)
                }.catch { error in
                    seal.reject(error)
                }
            }
            
        }.done{ id  in
            debugPrint("txId: \(id.toHexString())")
            expectation.fulfill()
            
        }.catch { error in
            debugPrint("send Transaction error: \(error)")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
