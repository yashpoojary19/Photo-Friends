//
//  ExampleCoreDataApp.swift
//  ExampleCoreData
//
//

import SwiftUI

@main
struct ExampleCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
