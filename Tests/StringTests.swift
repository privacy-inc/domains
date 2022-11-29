import XCTest
@testable import Domains

final class StringTests: XCTestCase {
    func testComparable() {
        XCTAssertEqual("www.ck/a/b", "www.avocado.www.ck/a/b".comparable)
        XCTAssertEqual("hello.com", "https://hello.com".comparable)
        XCTAssertEqual("hello.com/a?ds=1", "http://a.hello.com/a?ds=1".comparable)
        XCTAssertEqual("hello.com", "www.hello.com".comparable)
        XCTAssertEqual("hello.com/a/v/sd/dsfsafd/daf", "www.a.hello.com/a/v/sd/dsfsafd/daf".comparable)
        XCTAssertEqual("google.com/maps", "https://www.google.com/maps/@13.0080775,47.5045485,2z?ucbcb=1".comparable)
        XCTAssertEqual("wikipedia.org/wiki/Alan_Moore", "https://en.wikipedia.org/wiki/Alan_Moore".comparable)
        XCTAssertEqual("wikipedia.org/wiki/Alan_Moore", "https://en.wikipedia.org/wiki/Alan_Moore".comparable)
        XCTAssertEqual("ecosia.org/search?method=index&q=trees", "www.ecosia.org/search?method=index&q=trees".comparable)
        XCTAssertEqual("ecosia.org/search?q=trees", "ecosia.org/search?q=trees".comparable)
    }
    
    func testDomain() {
        XCTAssertEqual("avocado.www.ck", "www.avocado.www.ck/hello".domain)
        XCTAssertEqual("hello.com", "http://hello.com/a/b/c".domain)
        XCTAssertEqual("hello.com", "https://hello.com".domain)
        XCTAssertEqual("a.hello.com", "a.hello.com/a?var=3231123".domain)
        XCTAssertEqual("twitter.com", "twitter.com/_vaux".domain)
        XCTAssertEqual("", "https://".domain)
        XCTAssertEqual("", "".domain)
        XCTAssertEqual("wds", "wds".domain)
        XCTAssertEqual("linkedin.com", "https://www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domain)
        XCTAssertEqual("linkedin.com", "www.linkedin.com/authwall?trk=bf&trkInfo=bf&originalReferer=https://www.google.com&sessionRedirect=https%3A%2F%2Fde.linkedin.com%2Fin%2Fedal%25C3%25AD-c%25C3%25A1rdenas-beltr%25C3%25A1n-38670510a".domain)
        XCTAssertEqual("hello.com", "www.hello.com".domain)
        XCTAssertEqual("hello.com", "www.hello.com/lol".domain)
        XCTAssertEqual("hello.com", "www.hello.com:8080".domain)
        XCTAssertEqual("hello.com", "www.hello.com:8080/lol".domain)
        XCTAssertEqual("hello.world.com", "www.hello.world.com/lol".domain)
        XCTAssertEqual("hello.world.com", "https://hello.world.com/lol".domain)
        XCTAssertEqual("bbc.co.uk", "https://bbc.co.uk".domain)
        XCTAssertEqual("privacy-inc.github.io", "https://privacy-inc.github.io/about".domain)
    }
}
