# FlowSwift

## Features
* GRPC
* Account address generation and verification
* Support 'Secp256r1', 'Secp256k1'

## Installation
### Swift Package Manager
Add .package(url:_:) to your Package.swift:
```Swift
dependencies: [
    .package(url: "https://github.com/lishuailibertine/FlowSwift", .branch("main")),
],
```
## Usage
```Swift
// keypair
let secp256k1Keypair = try FlowSecp256k1Keypair(privateData: Data(hex: "a66165eb30c346688ad17d56eff7641cbf2dab7c3022b492b8cbad27838352e5"))
 XCTAssert(secp256k1Keypair.publicData.toHexString() == "c4ac362d98a8a74fc671d2ac0f58d5de7dd88b13b9639a9146a14d4c1b41e253a3fcd1a564e68f337abe69d048fd0cab90443b4ebc2529a1740613eda4f2e2d6")
 
let p256Keypair = try FlowECDSAP256Keypair(privateData: Data(hex: "af39ff9ad1db0c6df7c2e359f80ac95d71a82a4c03d3f169e98a81db00f9b717"))
XCTAssert(p256Keypair.publicData.toHexString() == "6595beefa6ace3aef00ccaed699b8468974bf2fed3f4272b56a40b746a0a3cc5fd6064da400efd5bd58b63014d8ec977a798074c92b714c8884f5e1881632725")
XCTAssert(FlowAddress.checkIntoAddress(chainCodeWord: .codeword_testnet, address: "0xa2dcfc6200593335"))

//address 
let address = FlowAddress.generateAddress(chainCodeWord: .codeword_testnet)
XCTAssert(FlowAddress.checkIntoAddress(chainCodeWord: .codeword_testnet, address: address))
```
## Other
* P256 algorithm reference link: https://github.com/ricmoo/GMEllipticCurveCrypto
