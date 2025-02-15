//
//  App.swift
//  SmartHome
//
//  Created by 김동준 on 2/15/25
//

import SwiftUI

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    init() {}
    
    var body: some Scene {
        WindowGroup {
            VStack {
                Text("Hello World~")
            }
        }
    }
}

#Preview {
    Text("Hi~")
}
