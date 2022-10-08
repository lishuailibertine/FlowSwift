//
//  File.swift
//  
//
//  Created by li shuai on 2022/8/23.
//

import Foundation
import GRPC
import SwiftProtobuf
import NIO
import CryptoSwift
import PromiseKit

public struct FlowGRPCRequest{
    public var host: String
    public var port: Int?
    public static let shared = FlowGRPCRequest()
    public init(host: String = "access.devnet.nodes.onflow.org", port: Int? = 9000){
        self.host = host
        self.port = port
    }
    public init(url: String) throws{
        guard url.isGRPC() else {
            throw FlowApiError.invalidUrl
        }
        let host = String(url.split(separator: ":")[0])
        let port = String(url.split(separator: ":")[1])
        self.init(host: host, port: Int(port))
    }
    public func channel(group: EventLoopGroup) -> GRPCChannel {
        let channel = ClientConnection.insecure(group: group).connect(host: host, port: port!)
        return channel
    }
    
    public func queryAccount(address: String) -> Promise<Flow_Access_GetAccountResponse> {
        return Promise { seal in
            let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
            defer {
                do {
                    try eventLoop.syncShutdownGracefully()
                } catch let error {
                    print("queryAccount error: \(error)")
                }
            }
            let getAccountRequest = Flow_Access_GetAccountRequest.with {
                $0.address = Data(hex: address)
            }
            seal.fulfill(try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getAccount(getAccountRequest).response.wait())
        }
    }
    
    public func queryLatestBlock(sealed: Bool = true) -> Promise<Flow_Access_BlockResponse>  {
        return Promise { seal in
            let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
            defer {
                do {
                    try eventLoop.syncShutdownGracefully()
                } catch let error {
                    print("queryLatestBlock error: \(error)")
                }
            }
            let getLastBlock = Flow_Access_GetLatestBlockRequest.with {
                $0.isSealed = sealed
            }
            seal.fulfill(try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getLatestBlock(getLastBlock).response.wait())
        }
    }
    
    public func sendTransaction(builder: FlowEntitiesTransactionBuilder) -> Promise<Flow_Access_SendTransactionResponse>  {
        return Promise { seal in
            let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
            defer {
                do {
                    try eventLoop.syncShutdownGracefully()
                } catch let error {
                    print("sendTransaction error: \(error)")
                }
            }
            let sendTransactionRequest = Flow_Access_SendTransactionRequest.with {
                $0.transaction = builder.transaction
            }
            seal.fulfill(try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).sendTransaction(sendTransactionRequest).response.wait())
        }
    }
    
    public func queryTransactionResult(id_p: Data) -> Promise<Flow_Access_TransactionResultResponse>  {
        return Promise { seal in
            let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
            defer {
                do {
                    try eventLoop.syncShutdownGracefully()
                } catch let error {
                    print("queryTransactionResult error: \(error)")
                }
            }
            let getTransactionResult = Flow_Access_GetTransactionRequest.with{
                $0.id = id_p
            }
            seal.fulfill(try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getTransactionResult(getTransactionResult).response.wait())
        }
    }
    
    public func executeScript(script: Data, arguments: [Data]) -> Promise<Flow_Access_ExecuteScriptResponse>  {
        return Promise { seal in
            let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
            defer {
                do {
                    try eventLoop.syncShutdownGracefully()
                } catch let error {
                    print("executeScript error: \(error)")
                }
            }
            let executeScriptRequest = Flow_Access_ExecuteScriptAtLatestBlockRequest.with{
                $0.arguments = arguments
                $0.script = script
            }
            seal.fulfill(try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).executeScriptAtLatestBlock(executeScriptRequest).response.wait())
        }
    }
}
