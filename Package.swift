// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MEWextensions",
  platforms: [
    .iOS(.v14),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "MEWextensions",
      targets: ["MEWextensions"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "MEWextensions",
      dependencies: [],
      path: "Sources"),
    .testTarget(
      name: "MEWextensionsTests",
      dependencies: ["MEWextensions"]),
  ]
)
