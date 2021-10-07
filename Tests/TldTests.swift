import XCTest
@testable import Domains

final class TldTests: XCTestCase {
    func testEmpty() {
        {
            XCTAssertEqual("", $0.name)
            XCTAssertTrue($0.suffix.isEmpty)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("", $0.minimal)
        } (Tld.deconstruct(url: ""))
    }
    
    func testUnknown() {
        {
            XCTAssertEqual("dsfasfsdfsdfsdfasdfasd", $0.name)
            XCTAssertTrue($0.suffix.isEmpty)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("dsfasfsdfsdfsdfasdfasd", $0.minimal)
        } (Tld.deconstruct(url: "dsfasfsdfsdfsdfasdfasd"))
    }
    
    func testBasic() {
        {
            XCTAssertEqual("avocado", $0.name)
            XCTAssertEqual("com", $0.suffix.first)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("avocado.com", $0.minimal)
        } (Tld.deconstruct(url: "avocado.com"))
    }
    
    func testDouble() {
        {
            XCTAssertEqual("avocado", $0.name)
            XCTAssertEqual("com", $0.suffix.first)
            XCTAssertEqual("mx", $0.suffix.last)
            XCTAssertEqual(1, $0.prefix.count)
            XCTAssertEqual("www", $0.prefix.first)
            XCTAssertEqual("avocado.com.mx", $0.minimal)
        } (Tld.deconstruct(url: "www.avocado.com.mx"))
    }
    
    func testWildcard() {
        {
            XCTAssertEqual("avocado", $0.name)
            XCTAssertEqual("chuchu", $0.suffix.first)
            XCTAssertEqual("ck", $0.suffix.last)
            XCTAssertEqual(3, $0.prefix.count)
            XCTAssertEqual("www", $0.prefix.first)
            XCTAssertEqual("total", $0.prefix.last)
            XCTAssertEqual("avocado.chuchu.ck", $0.minimal)
        } (Tld.deconstruct(url: "www.more.total.avocado.chuchu.ck"))
    }
    
    func testException() {
        {
            XCTAssertEqual("www", $0.name)
            XCTAssertEqual("ck", $0.suffix.first)
            XCTAssertEqual(2, $0.prefix.count)
            XCTAssertEqual("www", $0.prefix.first)
            XCTAssertEqual("avocado", $0.prefix.last)
            XCTAssertEqual("www.ck", $0.minimal)
        } (Tld.deconstruct(url: "www.avocado.www.ck"))
    }
}
