import Foundation
import UIKit

struct ShinnInstalledApp: Identifiable, Hashable {
    let bundleID: String
    let name: String
    let containerPath: String
    let version: String
    var id: String { bundleID }
}

enum ContainerStore {
    static let appDataRoot = "/var/mobile/Containers/Data/Application"

    static func resolveAppContainerPath(bundleID: String) -> String? {
        log("Container access is disabled in this safe build: \(bundleID)")
        return nil
    }

    static func resolveByMetadataScan(bundleID: String) -> String? { nil }
    static func isApplicationContainerPath(_ path: String) -> Bool { false }
    static func canonicalPath(_ rawPath: String) -> String { (rawPath as NSString).standardizingPath }
    static func enumerateDirectories(path: String, maxInode: Int64 = 2_000_000) -> [String] { [] }

    struct ContainerMetadata {
        let bundleID: String
        let displayName: String
    }

    static func readContainerMetadata(containerPath: String) -> ContainerMetadata? { nil }
    static func grantContainerAccess(_ path: String) -> Int64 { -1 }
}
