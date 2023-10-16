//
//  MainTabView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView {
            Group {
                LocationsListView()
                    .tabItem {
                        Label("List", systemImage: "list.dash")
                    }
                    .environment(\.managedObjectContext, viewContext)
                
                LocationsMapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
                    .environment(\.managedObjectContext, viewContext)
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}
