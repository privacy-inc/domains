import Foundation

public struct Domain {
    public let name: String
    public let prefix: [String]
    public let suffix: [String]
    
    public var minimal: String {
        name + (suffix.isEmpty
        ? ""
        : "." + suffix
            .joined(separator: "."))
    }
    
    public var prefixLenght: Int {
        prefix
            .map {
                $0.count + 1
            }
            .reduce(0, +)
    }
    
    init() {
        self.init(name: "", prefix: [], suffix: [])
    }
    
    private init(name: String, prefix: [String], suffix: [String]) {
        self.name = name
        self.prefix = prefix
        self.suffix = suffix
    }
    
    func with(name: String) -> Self {
        .init(name: name, prefix: prefix, suffix: suffix)
    }
    
    func with(prefix: String) -> Self {
        .init(name: name, prefix: [prefix] + self.prefix, suffix: suffix)
    }
    
    func with(suffix: String) -> Self {
        .init(name: name, prefix: prefix, suffix: [suffix] + self.suffix)
    }
}
