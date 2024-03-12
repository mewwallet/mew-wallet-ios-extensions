// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "mew-wallet-ios-extensions",
  platforms: [
    .iOS(.v14),
    .macOS(.v11)
  ],
  products: [
    .library(
      name: "mew-wallet-ios-extensions",
      targets: ["mew-wallet-ios-extensions"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-testing.git", branch: "0.5.1"),
  ],
  targets: [
    .target(
      name: "mew-wallet-ios-extensions",
      dependencies: [],
      path: "Sources",
      resources: [
        .copy("Privacy/PrivacyInfo.xcprivacy")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
    
    .testTarget(
      name: "mew-wallet-ios-extensions-tests",
      dependencies: [
        "mew-wallet-ios-extensions",
        .product(name: "Testing", package: "swift-testing")
      ],
      swiftSettings: [
        .enableExperimentalFeature("StrictConcurrency=complete")
      ]
    ),
  ]
)
