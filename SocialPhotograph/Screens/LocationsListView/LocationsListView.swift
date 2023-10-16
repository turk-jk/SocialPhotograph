//
//  LocationsListView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import Foundation
import SwiftUI

struct LocationsListView: View {
    @State private var showDeletionErrorAlert = false
    @State private var showAdditionErrorAlert = false
    @State private var shouldPresentAddingNewLocation = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default)
    private var locations: FetchedResults<Location>
    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                    NavigationLink {
                        LocationDetailsView(viewModel: LocationDetailsViewModel(location: location))
                    } label: {
                        Text(location.name ?? "")
                    }
                }
                .onDelete(perform: deleteLocations)
            }
            .sheet(isPresented: $shouldPresentAddingNewLocation, content: {
                AddingLocationNewView(viewModel: AddingLocationNewViewModel(viewContext: viewContext))
            })
            .alert(isPresented: $showDeletionErrorAlert) {
                Alert(
                    title: Text("Deletion Error"),
                    message: Text("Please kill the app and try again")
                )
            }
            .toolbar {
                if !locations.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add New Location", systemImage: "plus")
                    }
                }
            }
            .alert(isPresented: $showAdditionErrorAlert) {
                Alert(
                    title: Text("Adding Location Error"),
                    message: Text("Please kill the app and try again")
                )
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("List of Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteLocations(offsets: IndexSet) {
        withAnimation {
            offsets.map { locations[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                self.showDeletionErrorAlert = true
            }
        }
    }
    private func addItem() {
        shouldPresentAddingNewLocation = true
    }
}
