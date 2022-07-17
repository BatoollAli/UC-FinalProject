//
//  FullMoonApp.swift
//  FullMoon
//
//  Created by Batool Hussain on 09/07/2022.
//

import SwiftUI

@main
struct FullMoonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
