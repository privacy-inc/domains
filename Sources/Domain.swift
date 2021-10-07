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
}
