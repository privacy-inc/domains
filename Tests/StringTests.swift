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
        XCTAssertEqual("", "https://".domainMinimal)
        XCTAssertEqual("", "".domainMinimal)
        XCTAssertEqual("wds", "wds".domainMinimal)
        XCTAssertEqual("linkedin.com", "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domainMinimal)
        XCTAssertEqual("linkedin.com", "www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domainMinimal)
        XCTAssertEqual("hello.com", "www.hello.com".domainMinimal)
        XCTAssertEqual("hello.com", "www.hello.com/lol".domainMinimal)
        XCTAssertEqual("hello.com", "www.hello.com:8080".domainMinimal)
        XCTAssertEqual("hello.com", "www.hello.com:8080/lol".domainMinimal)
        XCTAssertEqual("world.com", "www.hello.world.com/lol".domainMinimal)
        XCTAssertEqual("world.com", "https://hello.world.com/lol".domainMinimal)
        XCTAssertEqual("bbc.co.uk", "https://bbc.co.uk".domainMinimal)
        XCTAssertEqual("privacy-inc.github.io", "https://privacy-inc.github.io/about".domainMinimal)
    }

    func testDomainFull() {
        XCTAssertEqual("www.avocado.www.ck", "www.avocado.www.ck/hello".domainFull)
        XCTAssertEqual("hello.com", "https://hello.com/a/b/c".domainFull)
        XCTAssertEqual("hello.com", "http://hello.com".domainFull)
        XCTAssertEqual("a.hello.com", "https://a.hello.com/a?var=3231123".domainFull)
        XCTAssertEqual("twitter.com", "twitter.com/_vaux".domainFull)
    }
}
