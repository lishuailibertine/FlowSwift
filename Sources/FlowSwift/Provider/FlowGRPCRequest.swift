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

public struct FlowGRPCRequest{
    public var host: String
    public var port: Int
    public static let shared = FlowGRPCRequest()
    public init(host: String = "access.mainnet.nodes.onflow.org", port: Int = 9000){
        self.host = host
        self.port = port
    }
    public mutating func configRequest(urlStr: String) throws {
        guard let url = URL(string: urlStr) else {
            throw FlowApiError.configRequestError
        }
        guard let _host = url.host, let _port = url.port else {
            throw FlowApiError.configRequestError
        }
        self.host = _host
        self.port = _port
    }
    
    public func channel(group: EventLoopGroup) -> GRPCChannel {
        let channel = ClientConnection.insecure(group: group).connect(host: host, port: port)
        return channel
    }
    
    public func queryAccount(address: String) throws -> Flow_Access_GetAccountResponse {
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
        return try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getAccount(getAccountRequest).response.wait()
    }
    
    public func queryLatestBlock(sealed: Bool) throws -> Flow_Access_BlockResponse {
        
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
        defer {
            do {
                try eventLoop.syncShutdownGracefully()
            } catch let error {
                print("queryAccount error: \(error)")
            }
        }
        let getLastBlock = Flow_Access_GetLatestBlockRequest.with {
            $0.isSealed = sealed
        }
        return try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getLatestBlock(getLastBlock).response.wait()
    }
    
    public func sendTransaction(transactionMessage: Flow_Entities_Transaction)  throws -> Flow_Access_SendTransactionResponse {
        
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
        defer {
            do {
                try eventLoop.syncShutdownGracefully()
            } catch let error {
                print("queryAccount error: \(error)")
            }
        }
        let sendTransactionRequest = Flow_Access_SendTransactionRequest.with {
            $0.transaction = transactionMessage
        }
        return try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).sendTransaction(sendTransactionRequest).response.wait()
    }
    
    public func queryTransactionResult(id_p: Data) throws -> Flow_Access_TransactionResultResponse {

        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
        defer {
            do {
                try eventLoop.syncShutdownGracefully()
            } catch let error {
                print("queryAccount error: \(error)")
            }
        }
        let getTransactionResult = Flow_Access_GetTransactionRequest.with{
            $0.id = id_p
        }
        return try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).getTransactionResult(getTransactionResult).response.wait()
    }
    
    public func executeScript(script: Data, arguments: [Data]) throws -> Flow_Access_ExecuteScriptResponse {
        let eventLoop = MultiThreadedEventLoopGroup(numberOfThreads: 5)
        defer {
            do {
                try eventLoop.syncShutdownGracefully()
            } catch let error {
                print("queryAccount error: \(error)")
            }
        }
        let executeScriptRequest = Flow_Access_ExecuteScriptAtLatestBlockRequest.with{
            $0.arguments = arguments
            $0.script = script
        }
        return try Flow_Access_AccessAPIClient(channel: self.channel(group: eventLoop)).executeScriptAtLatestBlock(executeScriptRequest).response.wait()
    }
}
