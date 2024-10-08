// swift-tools-version:6.0

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
  ],
  targets: [
    .target(
      name: "mew-wallet-ios-extensions",
      dependencies: [],
      path: "Sources",
      resources: [
        .copy("Privacy/PrivacyInfo.xcprivacy")
      ]
    ),
    .testTarget(
      name: "mew-wallet-ios-extensions-tests",
      dependencies: [
        "mew-wallet-ios-extensions"
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)

for target in package.targets {
  target.swiftSettings = target.swiftSettings ?? []
  target.swiftSettings?.append(contentsOf: [
    .enableUpcomingFeature("ExistentialAny"),
    .enableExperimentalFeature("StrictConcurrency=complete")
  ])
}
