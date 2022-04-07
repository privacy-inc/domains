import Foundation

extension String {
    public var domainMinimal: String {
        domain
            .minimal
            .lowercased()
    }
    
    public var domainFull: String {
        domain
            .median
            .lowercased()
    }
    
    public var comparable: String {
        schemeless
            .dropFirst(domain.prefixLenght)
            .components(separatedBy: "/")
            .prefix(2)
            .joined(separator: "/")
    }
    
    private var domain: Domain {
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
