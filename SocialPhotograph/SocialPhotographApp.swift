//
//  SocialPhotographApp.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI

@main
struct SocialPhotographApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
