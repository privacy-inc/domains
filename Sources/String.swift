import Foundation

extension String {
    func components<Result>(transform: ([Self]) -> Result) -> Result {
        transform(replacingOccurrences(of: "https://", with: "")
                    .replacingOccurrences(of: "http://", with: "")
                    .components(separatedBy: "/")
                    .first!
                    .components(separatedBy: ":")
                    .first!
                    .components(separatedBy: "."))
    }
}
