import Foundation

extension String {
    public var domainComplete: String { domain.complete }
    public var domainMinimal: String { domain.minimal }
    
    public var domainComparable: String {
        schemeless
            .dropFirst(domain.prefixLength)
            .components(separatedBy: "/")
            .filter {
                !$0.contains("@")
            }
            .joined(separator: "/")
    }
    
    public var schemeless: String {
        lowercased()
            .replacingOccurrences(of: "https://", with: "")
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
