import XCTest
@testable import Domains

final class StringTests: XCTestCase {
    func testPrefixLenght() {
        XCTAssertEqual(12, "www.avocado.www.ck/a/b".domainPrefixLenght)
        XCTAssertEqual(0, "https://hello.com".domainPrefixLenght)
        XCTAssertEqual(2, "http://a.hello.com/a?ds=1".domainPrefixLenght)
        XCTAssertEqual(4, "www.hello.com".domainPrefixLenght)
        XCTAssertEqual(6, "www.a.hello.com/a/v/sd/dsfsafd/daf".domainPrefixLenght)
    }
    
    func testDomainMinimal() {
        XCTAssertEqual("www.ck", "www.avocado.www.ck/hello".domainMinimal)
        XCTAssertEqual("hello.com", "http://hello.com/a/b/c".domainMinimal)
        XCTAssertEqual("hello.com", "https://hello.com".domainMinimal)
        XCTAssertEqual("hello.com", "a.hello.com/a?var=3231123".domainMinimal)
        XCTAssertEqual("twitter.com", "twitter.com/_vaux".domainMinimal)
    }

    func testDomainFull() {
        XCTAssertEqual("www.avocado.www.ck", "www.avocado.www.ck/hello".domainFull)
        XCTAssertEqual("hello.com", "https://hello.com/a/b/c".domainFull)
        XCTAssertEqual("hello.com", "http://hello.com".domainFull)
        XCTAssertEqual("a.hello.com", "https://a.hello.com/a?var=3231123".domainFull)
        XCTAssertEqual("twitter.com", "twitter.com/_vaux".domainFull)
    }
}
