//
//  Project.swift
//  SmartHomeManifests
//
//  Created by 김동준 on 2/15/25
//

import ProjectDescription

let project = Project(
    name: "App",
    organizationName: "com.jumy.smart-home",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    ),
    settings: .settings(
        configurations: [
            .debug(name: .debug, xcconfig: .relativeToRoot("XCConfig/Debug.xcconfig")),
            .release(name: .release, xcconfig: .relativeToRoot("XCConfig/Release.xcconfig"))
        ],
        defaultSettings: .recommended(
            excluding: [
                "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
            ]
        )
    ),
    targets: [
        .target(
            name: "App",
            destinations: [.iPhone],
            product: .app,
            bundleId: "${BUNDLE_IDENTIFIER}",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                // TODO: Add Dependency
            ],
            settings: .settings(
                configurations: [
                    .debug(name: .debug, xcconfig: .relativeToRoot("XCConfig/Debug.xcconfig")),
                    .release(name: .release, xcconfig: .relativeToRoot("XCConfig/Release.xcconfig"))
                ]
            )
        )
    ],
    schemes: [
        .scheme(
            name: "App-Debug",
            buildAction: .buildAction(targets: ["App"]),
            testAction: nil,
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .debug),
            profileAction: .profileAction(configuration: .debug),
            analyzeAction: .analyzeAction(configuration: .debug)
        ),
        .scheme(
            name: "App-Release",
            buildAction: .buildAction(targets: ["App"]),
            testAction: nil,
            runAction: .runAction(configuration: .release),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .release)
        )
    ],
    additionalFiles: [
        "../../XCConfig/MQTTSetting.xcconfig"
    ]
)
