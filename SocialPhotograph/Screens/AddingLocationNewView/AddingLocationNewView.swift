//
//  AddingLocationNewView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI
import Foundation

struct AddingLocationNewView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: AddingLocationNewViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10){
                List {
                    Section(header: Text("Location Name")) {
                        TextField(
                            "Location Name",
                            text: $viewModel.name
                        )
                    }
                    Section{
                        HStack {
                            Text("Latitude: ")
                                .foregroundColor(.gray)
                            TextField(
                                "",
                                value: $viewModel.lat,
                                formatter: .forLocationDegrees
                            )
                        }
                        HStack{
                            Text("Longitude: ")
                                .foregroundColor(.gray)
                            TextField(
                                "",
                                value: $viewModel.lng,
                                formatter: .forLocationDegrees
                            )
                        }
                    } header: {
                        HStack{
                            Text("Coordinate")
                            Spacer()
                            Button {
                                viewModel.showMapToSelect()
                            } label: {
                                Image(systemName: "mappin.and.ellipse")
                            }
                        }
                    }
                    
                    Section(header: Text("Note")) {
                        TextEditor(text: $viewModel.note)
                    }
                }
                
                
                Spacer()
                if viewModel.shouldShowSavingButton {
                    
                    Button {
                        viewModel.save()
                    } label: {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .padding([.trailing, .leading], 16)
                    .padding(.bottom, 32)

                }
                
            }
            .sheet(isPresented: $viewModel.shouldShowMapToSelect, content: {
                SelectLocationMapView(lat: $viewModel.lat, lng: $viewModel.lng)
            })
            .onChange(of: viewModel.shouldDismiss) { shouldDismiss in
                if shouldDismiss {
                    dismiss()
                }
            }
            .alert(isPresented: $viewModel.showSavingErrorAlert) {
                Alert(
                    title: Text("Saving Location Error"),
                    message: Text("Please kill the app and try again")
                )
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Add New Location")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func dismiss() {
      presentationMode.wrappedValue.dismiss()
    }
}
