//
//  AddingLocationNewViewModel.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import Foundation
import CoreData

class AddingLocationNewViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext
    @Published var shouldDismiss = false
    @Published var shouldShowMapToSelect = false
    @Published var showSavingErrorAlert = false
    @Published var name = ""
    @Published var note = ""
    @Published var lat: Double = 0
    @Published var lng: Double = 0
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }

    var shouldShowSavingButton: Bool {
        !name.isEmpty &&
        lat != 0 &&
        lng != 0
    }
    func showMapToSelect() {
        shouldShowMapToSelect = true
    }

    func save() {
        let location = Location(context: viewContext)
        location.name = name
        location.lat = lat
        location.lng = lng
        location.note = note
        
        do {
            try viewContext.save()
            shouldDismiss = true
        } catch {
            showSavingErrorAlert = true
        }
    }
}
