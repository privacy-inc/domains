import Foundation

extension Tld {
    public static func deconstruct(url: String) -> Domain {
        url
            .components {
                var components = $0
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
                                    suffix.insert($0, at: 0)
                                    components
                                        .popLast()
                                        .map {
                                            domain = $0
                                        }
                                }
                            }
                        next = nil
                    case .end:
                        suffix.insert(next!, at: 0)
                        components
                            .popLast()
                            .map {
                                domain = $0
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
}
