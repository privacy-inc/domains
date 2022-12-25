import Foundation

private let directory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
private let def = directory.appending(path: "Sources/Tld.swift", directoryHint: .notDirectory)
private let suffix = directory.appending(path: "Sources/Tld.Suffix.swift", directoryHint: .notDirectory)
private let dat = directory.appending(path: "Resources/Tld.public_suffix_list.dat", directoryHint: .notDirectory)

let result = Parser
    .parse(content: String(decoding: try! Data(contentsOf: dat), as: UTF8.self))
try! Data(result
        .enum
        .utf8)
    .write(to: def, options: .atomic)
try! Data(result
        .suffix
        .utf8)
    .write(to: suffix, options: .atomic)

print("Updated enum and suffix!")
