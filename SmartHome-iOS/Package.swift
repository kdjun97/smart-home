// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ]
        )
    )
#endif

let package = Package(
    name: "SmartHome",
    dependencies: [
        // TODO: Add Dependency
    ]
)
