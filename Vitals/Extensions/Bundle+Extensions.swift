//
// Copyright (c) 2026, Samuel Majtan
//
// SPDX-License-Identifier: GPL-3.0
//

import Foundation

extension Bundle {

    /// The app's display name from the Info.plist (`CFBundleName`).
    static var appName: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }

    /// The app's version number from the Info.plist (`CFBundleShortVersionString`).
    static var appVersion: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// The app's build number from the Info.plist (`CFBundleVersion`).
    static var appBuild: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

    /// The app's bundle identifier from the Info.plist (`CFBundleIdentifier`).
    static var appIdentifier: String? {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
    }

    /// The app's copyright.
    static var appCopyright: String? {
        Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String
    }

}

extension Bundle {

    /// The file path of the app's icon.
    ///
    /// This property retrieves the icon filename from the app's `Info.plist`,
    /// falling back to `"AppIcon"` if no entry is found. It constructs the
    /// full path within the app bundle's `Resources` directory.
    ///
    /// - Returns: The full file path to the `.icns` icon.
    var iconPath: String {
        let iconFile = infoDictionary?["CFBundleIconFile"] as? String
        ?? infoDictionary?["CFBundleIconName"] as? String
        ?? "AppIcon"

        return bundleURL
            .appendingPathComponent("Contents")
            .appendingPathComponent("Resources")
            .appendingPathComponent(iconFile.hasSuffix(".icns") ?
                                    iconFile : "\(iconFile).icns")
            .path(percentEncoded: false)
    }

}

extension Bundle {

    /// A Boolean value indicating whether the app is currently running in a test environment (via XCTest).
    var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

}
