//
//  AucaPlusApp.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 31/03/2023.
//

import SwiftUI

@main
struct AucaPlusApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
