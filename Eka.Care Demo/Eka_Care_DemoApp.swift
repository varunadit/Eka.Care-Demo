//
//  Eka_Care_DemoApp.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import SwiftUI

@main
struct Eka_Care_DemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
