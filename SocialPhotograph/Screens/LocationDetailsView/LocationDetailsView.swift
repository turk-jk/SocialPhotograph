//
//  LocationDetailsView.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import SwiftUI
import Foundation

struct LocationDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: LocationDetailsViewModel

    var body: some View {
            VStack(alignment: .leading, spacing: 10){
                List {
                    Section(header: Text("Location Name")) {
                        TextField(
                            "Location Name",
                            text: $viewModel.name
                        )
                    }
                    Section(header: Text("Coordinate")) {
                        HStack {
                            Text("Latitude: ")
                            TextField(
                                "",
                                value: $viewModel.lat,
                                formatter: .forLocationDegrees
                            )
                        }
                        HStack{
                            Text("Longitude: ")
                            TextField(
                                "",
                                value: $viewModel.lng,
                                formatter: .forLocationDegrees
                            )
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
                }
                
            }
            .toolbar {
                ToolbarItem {
                    Button(action: viewModel.deleteLocation) {
                        Label("Delete Location", systemImage: "trash")
                    }
                }
            }
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
            .onAppear{
                viewModel.onAppear()
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Details of \(viewModel.name)")
            .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func dismiss() {
      presentationMode.wrappedValue.dismiss()
    }
}
