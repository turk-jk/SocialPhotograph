//
//  SelectLocationMapView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI
import MapKit

struct SelectLocationMapView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var lat: Double
    @Binding var lng: Double
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.860178, longitude: 151.212706), span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
    
    var body: some View {
        NavigationView {
            VStack{
                Map(coordinateRegion: $region)
                    .overlay(alignment: .center, content: {
                        PlaceAnnotationView(name: "New Location")
                    })
                Button {
                    // We could extract this functionality into a viewmodel. but it's only passing data no logic in here
                    lat = region.center.latitude
                    lng = region.center.longitude
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .padding([.trailing, .leading, .bottom], 16)
                
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Select Location")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    private func dismiss() {
      presentationMode.wrappedValue.dismiss()
    }
}
