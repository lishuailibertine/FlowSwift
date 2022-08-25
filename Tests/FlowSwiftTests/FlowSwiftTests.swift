import XCTest
import CryptoSwift

@testable import FlowSwift

final class FlowSwiftTests: XCTestCase {
    func testExample() throws {
        debugPrint(FlowAddress.generateAddress())
    }
}
