import XCTest
@testable import ipaddr

class ipaddrTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ipaddr().text, "Hello, World!")
    }


    static var allTests : [(String, (ipaddrTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
