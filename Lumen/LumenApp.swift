//
//  LumenApp.swift
//  Lumen
//
//  Created by Dquavius Griffin on 10/23/20.
//

import SwiftUI

@main
struct LumenApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
