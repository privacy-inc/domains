import Foundation

extension String {
    public var domain: String {
        _domain
            .minimal
            .lowercased()
    }
    
    public var comparable: String {
        schemeless
            .dropFirst(_domain.prefixLenght)
            .components(separatedBy: "/")
            .filter {
                !$0.contains("@")
            }
            .joined(separator: "/")
    }
    
    private var _domain: Domain {
        schemeless
            .components(separatedBy: "/")
            .first!
            .components(separatedBy: ":")
            .first
            .map(Tld.domain(host:))!
    }
    
    private var schemeless: String {
        replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
    }
}
