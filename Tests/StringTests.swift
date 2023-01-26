import XCTest
@testable import Domains

final class StringTests: XCTestCase {
    func testComparable() {
        XCTAssertEqual("www.ck/a/b", "www.avocado.www.ck/a/b".domainComparable)
        XCTAssertEqual("hello.com", "https://hello.com".domainComparable)
        XCTAssertEqual("hello.com/a?ds=1", "http://a.hello.com/a?ds=1".domainComparable)
        XCTAssertEqual("hello.com", "www.hello.com".domainComparable)
        XCTAssertEqual("hello.com/a/v/sd/dsfsafd/daf", "www.a.hello.com/a/v/sd/dsfsafd/daf".domainComparable)
        XCTAssertEqual("google.com/maps", "https://www.google.com/maps/@13.0080775,47.5045485,2z?ucbcb=1".domainComparable)
        XCTAssertEqual("wikipedia.org/wiki/alan_moore", "https://en.wikipedia.org/wiki/alan_moore".domainComparable)
        XCTAssertEqual("wikipedia.org/wiki/alan_moore", "https://en.wikipedia.org/wiki/alan_moore".domainComparable)
        XCTAssertEqual("ecosia.org/search?method=index&q=trees", "www.ecosia.org/search?method=index&q=trees".domainComparable)
        XCTAssertEqual("ecosia.org/search?q=trees", "ecosia.org/search?q=trees".domainComparable)
    }
    
    func testDomain() {
        XCTAssertEqual("avocado.www.ck", "www.avocado.www.ck/hello".domainComplete)
        XCTAssertEqual("hello.com", "http://hello.com/a/b/c".domainComplete)
        XCTAssertEqual("hello.com", "https://hello.com".domainComplete)
        XCTAssertEqual("a.hello.com", "a.hello.com/a?var=3231123".domainComplete)
        XCTAssertEqual("twitter.com", "twitter.com/_vaux".domainComplete)
        XCTAssertEqual("", "https://".domainComplete)
        XCTAssertEqual("", "".domainComplete)
        XCTAssertEqual("wds", "wds".domainComplete)
        XCTAssertEqual("linkedin.com", "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domainComplete)
        XCTAssertEqual("linkedin.com", "www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domainComplete)
        XCTAssertEqual("hello.com", "www.hello.com".domainComplete)
        XCTAssertEqual("hello.com", "www.hello.com/lol".domainComplete)
        XCTAssertEqual("hello.com", "www.hello.com:8080".domainComplete)
        XCTAssertEqual("hello.com", "www.hello.com:8080/lol".domainComplete)
        XCTAssertEqual("hello.world.com", "www.hello.world.com/lol".domainComplete)
        XCTAssertEqual("hello.world.com", "https://hello.world.com/lol".domainComplete)
        XCTAssertEqual("bbc.co.uk", "https://bbc.co.uk".domainComplete)
        XCTAssertEqual("privacy-inc.github.io", "https://privacy-inc.github.io/about".domainComplete)
    }
}
