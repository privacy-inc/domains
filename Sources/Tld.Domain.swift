import Foundation

extension Tld {
    public static func domain(host: String) -> Domain {
        host
            .components(separatedBy: ".")
            .reversed()
            .reduce(into: (.init(), .context(Tld.suffix))) { (result: inout (domain: Domain, step: Step), component) in
                switch result.step {
                case let .context(context):
                    
                    switch context[component] {
                    case let .previous(previous):
                        
                        result.step = .context(previous)
                        result.domain = result
                            .domain
                            .with(suffix: component)
                        
                    case let .wildcard(wildcard):
                        
                        result.step = .wildcard(wildcard)
                        result.domain = result
                            .domain
                            .with(suffix: component)
                        
                    case .end:
                        
                        result.step = .finished
                        result.domain = result
                            .domain
                            .with(name: component)
                        
                    case nil:
                        
                        result.step = .prefix
                        result.domain = result
                            .domain
                            .with(name: component)
                        
                    }
                    
                case let .wildcard(wildcard):
                    
                    if wildcard.contains(component) {
                        result.step = .prefix
                        result.domain = result
                            .domain
                            .with(name: component)
                    } else {
                        result.step = .close
                        result.domain = result
                            .domain
                            .with(suffix: component)
                    }
                    
                case .close:
                    
                    result.step = .prefix
                    result.domain = result
                        .domain
                        .with(name: component)
                    
                case .finished:
                    
                    result.step = .prefix
                    result.domain = result
                        .domain
                        .with(suffix: result.domain.name)
                        .with(name: component)
                    
                case .prefix:
                    
                    result.domain = result
                        .domain
                        .with(prefix: component)
                }
            }
            .domain
    }
}
