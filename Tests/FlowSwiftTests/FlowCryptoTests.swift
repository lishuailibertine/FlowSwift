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

    func test_createAccount_secp256k1_publicKey() throws {
        let secp256k1Keypair = try FlowSecp256k1Keypair()
        //a66165eb30c346688ad17d56eff7641cbf2dab7c3022b492b8cbad27838352e5
        debugPrint("secp256k1 privateKey: " + secp256k1Keypair.privateData.toHexString())
        //c4ac362d98a8a74fc671d2ac0f58d5de7dd88b13b9639a9146a14d4c1b41e253a3fcd1a564e68f337abe69d048fd0cab90443b4ebc2529a1740613eda4f2e2d6
        debugPrint("secp256k1 publicKey: " + secp256k1Keypair.publicData.toHexString())
        
        let p256Keypair = try FlowECDSAP256Keypair()
        //af39ff9ad1db0c6df7c2e359f80ac95d71a82a4c03d3f169e98a81db00f9b717
        debugPrint("p256 privateKey: " + p256Keypair.privateData.toHexString())
        //6595beefa6ace3aef00ccaed699b8468974bf2fed3f4272b56a40b746a0a3cc5fd6064da400efd5bd58b63014d8ec977a798074c92b714c8884f5e1881632725
        debugPrint("p256 publicKey: " + p256Keypair.publicData.toHexString())
        
        XCTAssert(FlowAddress.checkIntoAddress(chainCodeWord: .codeword_emulatornet, address: "0xa2dcfc6200593335"))
    }
    
}
