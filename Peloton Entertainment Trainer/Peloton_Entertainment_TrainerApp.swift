//
//  Peloton_Entertainment_TrainerApp.swift
//  Peloton Entertainment Trainer
//
//  Created by Marty Vasquez on 8/26/24.
//

import SwiftUI

@main
struct Peloton_Entertainment_TrainerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
