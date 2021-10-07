import Foundation

extension Tld {
    enum Step {
        case
        close,
        finished,
        prefix,
        context([Tld : Mode]),
        wildcard(Set<Tld>)
    }
}
