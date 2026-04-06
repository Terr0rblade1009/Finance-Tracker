// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FinanceTrackerCodeConnect",
    platforms: [.iOS(.v17), .macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/figma/code-connect", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "FinanceTrackerCodeConnect",
            dependencies: [
                .product(name: "Figma", package: "code-connect")
            ],
            path: ".",
            exclude: [
                "FinanceTracker/App",
                "FinanceTracker/Models",
                "FinanceTracker/Views",
                "FinanceTracker/ViewModels",
                "FinanceTracker/Services",
                "FinanceTracker/Utilities",
                "FinanceTracker/Resources",
                "FinanceTracker/Info.plist"
            ],
            sources: ["FinanceTracker/DesignSystem", "CodeConnect"]
        )
    ]
)
