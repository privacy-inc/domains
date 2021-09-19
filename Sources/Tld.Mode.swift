import Foundation

extension Tld {
    public enum Mode {
        case
        previous([Tld : Mode]),
        wildcard(Set<Tld>),
        end
    }
}
