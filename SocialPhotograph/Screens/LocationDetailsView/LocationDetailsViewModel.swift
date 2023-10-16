//
//  LocationDetailsViewModel.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import Foundation
import Combine

class LocationDetailsViewModel: ObservableObject {
    @Published var shouldDismiss = false
    @Published var showSavingErrorAlert = false
    @Published var name = ""
    @Published var note = ""
    @Published var lat: Double = 0
    @Published var lng: Double = 0
    var location: Location

    init(location: Location) {
        self.location = location
    }

    func onAppear() {
        name = location.name ?? ""
        note = location.note ?? ""
        lat = location.lat
        lng = location.lng
    }

    var shouldShowSavingButton: Bool {
        name != location.name ||
        note != location.note ||
        lat != location.lat ||
        lng != location.lng
    }
    
    func deleteLocation() {
        guard let context = location.managedObjectContext else {
            showSavingErrorAlert = true
            return
        }
        context.delete(location)
    }

    func save() {
        guard let context = location.managedObjectContext else {
            showSavingErrorAlert = true
            return
        }
        location.name = name
        location.lat = lat
        location.lng = lng
        location.note = note
        
        do {
            try context.save()
            shouldDismiss = true
        } catch {
            showSavingErrorAlert = true
        }
    }
}
