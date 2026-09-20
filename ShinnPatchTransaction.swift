import Foundation

struct ShinnTransactionReceipt: Equatable {
    let id: UUID
    let patchID: UUID
    let journalURL: URL
}

struct ShinnRestoreInspection: Equatable {
    let changedPaths: [String]
}

enum ShinnPatchTransaction {
    static func apply(
        project: ShinnPatchProject,
        backupRoot: URL,
        containerResolver: (String) throws -> URL,
        fileManager: FileManager = .default
    ) throws -> ShinnTransactionReceipt {
        throw ShinnPatchError.applyFailed
    }

    static func inspectRestore(
        receipt: ShinnTransactionReceipt,
        containerResolver: (String) throws -> URL,
        fileManager: FileManager = .default
    ) throws -> ShinnRestoreInspection {
        ShinnRestoreInspection(changedPaths: [])
    }

    static func restore(
        receipt: ShinnTransactionReceipt,
        allowChanged: Bool = false,
        containerResolver: (String) throws -> URL,
        fileManager: FileManager = .default
    ) throws {
        throw ShinnPatchError.restoreFailed
    }

    static func latestReceipt(
        patchID: UUID,
        backupRoot: URL,
        fileManager: FileManager = .default
    ) -> ShinnTransactionReceipt? {
        nil
    }

    static func canonicalBundleID(_ raw: String) throws -> String {
        let value = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !value.isEmpty,
              value.utf8.count <= 255,
              UUID(uuidString: value) == nil,
              !value.contains("/"),
              !value.contains("\\") else {
            throw ShinnPatchError.invalidBundle
        }
        return value
    }

    static func canonicalURL(_ url: URL) -> URL {
        var path = url.standardizedFileURL.path
        if path == "/var" || path.hasPrefix("/var/") {
            path = "/private" + path
        }
        return URL(fileURLWithPath: path, isDirectory: url.hasDirectoryPath).standardizedFileURL
    }
}