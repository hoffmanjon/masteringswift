import XCTest
@testable import echoClient

class echoClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(echoClient().text, "Hello, World!")
    }


    static var allTests : [(String, (echoClientTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
