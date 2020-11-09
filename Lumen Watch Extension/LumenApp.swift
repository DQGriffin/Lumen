//
//  LumenApp.swift
//  Lumen Watch Extension
//
//  Created by Dquavius Griffin on 11/7/20.
//

import SwiftUI

@main
struct LumenApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                WatchMainView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
