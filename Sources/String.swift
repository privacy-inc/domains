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
    
    public var domainPrefixLenght: Int {
        domain
            .prefixLenght
    }
    
    public var schemeless: String {
        replacingOccurrences(of: "https://", with: "")
            .replacingOccurrences(of: "http://", with: "")
    }
    
    private var domain: Domain {
        schemeless
            .components(separatedBy: "/")
            .first!
            .components(separatedBy: ":")
            .first
            .map(Tld.domain(host:))!
    }
}
