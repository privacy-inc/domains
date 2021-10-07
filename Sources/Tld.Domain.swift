import Foundation

extension Tld {
    public static func domain(host: String) -> Domain {
        var components = host.components(separatedBy: ".")
        var suffix = [String]()
        var domain = ""
        var next = components
            .popLast()
        var context: [Tld : Tld.Mode]?
        
        while next != nil {
            var mode: Tld.Mode?
            if context == nil {
                mode = Tld.suffix[next!]
            } else {
                mode = context![next!]
            }
            
            switch mode {
            case let .previous(previous):
                context = previous
                suffix.insert(next!, at: 0)
                next = components
                    .popLast()
            case let .wildcard(wildcard):
                suffix.insert(next!, at: 0)
                components
                    .popLast()
                    .map {
                        if wildcard.contains($0) {
                            domain = $0
                        } else {
                            if components.isEmpty {
                                domain = $0
                            } else {
                                suffix.insert($0, at: 0)
                                domain = components.popLast()!
                            }
                        }
                    }
                next = nil
            case .end:
                if components.isEmpty {
                    domain = next!
                } else {
                    suffix.insert(next!, at: 0)
                    domain = components.popLast()!
                }
                next = nil
            case nil:
                domain = next!
                next = nil
            }
        }
        
        return .init(name: domain, prefix: components, suffix: suffix)
    }
}
