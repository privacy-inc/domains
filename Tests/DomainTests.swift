import XCTest
@testable import Domains

final class DomainTests: XCTestCase {
    func testURLHost() {
        let url = URL(string: "https://avocado.com:8080/some/else.xtr?something=done&another=true#total")!
        XCTAssertEqual("avocado.com", url.host)
        XCTAssertEqual("/some/else.xtr", url.path)
        XCTAssertEqual(["some", "else.xtr"], url.path.components(separatedBy: "/").dropFirst())
        XCTAssertEqual([], URL(string: "https://avocado.com")!.path.components(separatedBy: "/").dropFirst())
        XCTAssertEqual("total", url.fragment)
        XCTAssertEqual("something=done&another=true", url.query)
    }
    
    func testHttpbin() {
        let url = URL(string: "https://httpbin.org/base64/PHNjcmlwdD5vbm1lc3NhZ2UgPSBlID0+IGUuZGF0YS5wb3N0TWVzc2FnZShuYXZpZ2F0b3IuY29va2llRW5hYmxlZCk8L3NjcmlwdD4=")!
        let domain = Tld.domain(host: url.host!)
        XCTAssertEqual("httpbin", domain.name)
        XCTAssertEqual("org", domain.suffix.first)
    }
    
    func testEmpty() {
        {
            XCTAssertEqual("", $0.name)
            XCTAssertTrue($0.suffix.isEmpty)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("", $0.minimal)
        } (Tld.domain(host: ""))
    }
    
    func testUnknown() {
        {
            XCTAssertEqual("dsfasfsdfsdfsdfasdfasd", $0.name)
            XCTAssertTrue($0.suffix.isEmpty)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("dsfasfsdfsdfsdfasdfasd", $0.minimal)
        } (Tld.domain(host: "dsfasfsdfsdfsdfasdfasd"))
    }
    
    func testBasic() {
        {
            XCTAssertEqual("avocado", $0.name)
            XCTAssertEqual("com", $0.suffix.first)
            XCTAssertTrue($0.prefix.isEmpty)
            XCTAssertEqual("avocado.com", $0.minimal)
        } (Tld.domain(host: "avocado.com"))
    }
    
    func testDouble() {
        {
            XCTAssertEqual("avocado", $0.name)
            XCTAssertEqual(2, $0.suffix.count)
            XCTAssertEqual("com", $0.suffix.first)
            XCTAssertEqual("mx", $0.suffix.last)
            XCTAssertEqual(1, $0.prefix.count)
            XCTAssertEqual("www", $0.prefix.first)
            XCTAssertEqual("avocado.com.mx", $0.minimal)
        } (Tld.domain(host: "www.avocado.com.mx"))
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
        } (Tld.domain(host: "www.more.total.avocado.chuchu.ck"))
    }
    
    func testException() {
        {
            XCTAssertEqual("www", $0.name)
            XCTAssertEqual("ck", $0.suffix.first)
            XCTAssertEqual(2, $0.prefix.count)
            XCTAssertEqual("www", $0.prefix.first)
            XCTAssertEqual("avocado", $0.prefix.last)
            XCTAssertEqual("www.ck", $0.minimal)
        } (Tld.domain(host: "www.avocado.www.ck"))
    }
    
    func testPrefixLenght() {
        XCTAssertEqual(12, Tld.domain(host: "www.avocado.www.ck").prefixLenght)
        XCTAssertEqual(0, Tld.domain(host: "hello.com").prefixLenght)
        XCTAssertEqual(2, Tld.domain(host: "a.hello.com").prefixLenght)
        XCTAssertEqual(4, Tld.domain(host: "www.hello.com").prefixLenght)
        XCTAssertEqual(6, Tld.domain(host: "www.a.hello.com").prefixLenght)
    }
}
