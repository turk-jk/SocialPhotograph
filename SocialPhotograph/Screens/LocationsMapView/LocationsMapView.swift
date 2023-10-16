//
//  LocationsMapView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//
import SwiftUI
import MapKit

struct LocationsMapView: View {
    @State private var shouldPresentAdding = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Location.name, ascending: true)],
        animation: .default)
    private var locations: FetchedResults<Location>
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.860178, longitude: 151.212706), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                            Text("Details View")
                    } label: {
                        PlaceAnnotationView(name: location.name ?? "")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add New Location", systemImage: "plus")
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Map of Locations")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addItem() {
        shouldPresentAdding = true
    }
}
