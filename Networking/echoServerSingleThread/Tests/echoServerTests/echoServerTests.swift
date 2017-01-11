import XCTest
@testable import echoServer

class echoServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(echoServer().text, "Hello, World!")
    }


    static var allTests : [(String, (echoServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
