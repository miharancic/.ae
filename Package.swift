// swift-tools-version:5.1

/**
 *  https://github.com/tadija/AE
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import PackageDescription

let package = Package(
    name: "AE",
    products: [
        .executable(
            name: "ae",
            targets: ["Cli"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/tadija/AECli.git",
            .upToNextMinor(from: "0.2.0")
        ),
        .package(
            url: "https://github.com/tadija/AEShell.git",
            .upToNextMinor(from: "0.2.0")
        ),
    ],
    targets: [
        .target(
            name: "Cli",
            dependencies: ["Core", "My"]
        ),
        .target(
            name: "My",
            dependencies: ["Core"]
        ),
        .target(
            name: "Core",
            dependencies: ["AECli", "AEShell"]
        ),
        .testTarget(
            name: "AETests",
            dependencies: ["Core"]
        ),
    ]
)
