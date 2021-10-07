import XCTest

final class ParserSuffixTests: XCTestCase {
    func testEmpty() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
]
}

""", Parser.parse(content: "").suffix)
    }
    
    func testBasic() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        ._0 : .end,
        .com : .end,
        .net : .end,
        .org : .end]
}

""", Parser.parse(content: """
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// Please pull this list from, and only from https://publicsuffix.org/list/public_suffix_list.dat,
// rather than any other VCS sites. Pulling from any other URL is not guaranteed to be supported.

// Instructions on pulling and using this list can be found at https://publicsuffix.org/list/.

// ===BEGIN ICANN DOMAINS===

// ac : https://en.wikipedia.org/wiki/.ac
org
net
org
org
com
0
""").suffix)
    }
    
    func testPrevious() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        .com : .end,
        .org : .previous([
            ._0 : .end,
            ._1hello_world : .end,
            .abc : .previous([
                .nan : .end,
                .tl : .end]),
            .hello_world : .end,
            .zc8 : .end])]
}

""", Parser.parse(content: """
org
zc8.org
org
abc.org
com
tl.abc.org
0.org
nan.abc.org
hello-world.org
1hello-world.org
org
""").suffix)
    }
    
    func testWildcard() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        .ck : .wildcard(.init([
]))]
}

""", Parser.parse(content: """
*.ck
""").suffix)
    }
    
    func testException() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        .ck : .wildcard(.init([
            .www]))]
}

""", Parser.parse(content: """
!www.ck
""").suffix)
    }
    
    func testWildCardAndException() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        .ck : .wildcard(.init([
            .asd,
            .www]))]
}

""", Parser.parse(content: """
*.ck
!www.ck
!asd.ck
""").suffix)
    }
    
    func testWildCardAndExceptionInversed() {
        XCTAssertEqual("""
import Foundation

extension Tld {
    public static let suffix: [Tld : Mode] = [
        .ck : .wildcard(.init([
            ._0,
            .asd,
            .www]))]
}

""", Parser.parse(content: """
!www.ck
!asd.ck
!0.ck
*.ck
""").suffix)
    }
}
