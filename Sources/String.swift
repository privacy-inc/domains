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
    
    public var historical: String {
        {
            $0.count > 2 ? $0.dropLast().joined(separator: "/") : $0.joined(separator: "/")
        } (schemeless.dropFirst(domain.prefixLenght).components(separatedBy: "/"))
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
