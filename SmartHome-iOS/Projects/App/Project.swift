//
//  Project.swift
//  SmartHomeManifests
//
//  Created by 김동준 on 2/15/25
//

import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "SmartHome",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.jumy.smart-home",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .file(path: "Support/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                // TODO: Add Dependency
            ]
        )
    ]
)
