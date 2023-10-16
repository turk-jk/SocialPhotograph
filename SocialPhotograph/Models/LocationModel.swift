//
//  LocationModel.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//
import Foundation
struct LocationsResponseModel: Decodable {
    let locations: [LocationModel]
}
struct LocationModel: Decodable {
    let name: String
    let lat: Double
    let lng: Double
    let note: String?
}

extension TestData{
    static let defaultLocationsResponseModel: LocationsResponseModel = dataFromFile(file: .defaultLocations)
    static let locationModel: LocationModel = .init(name: "Manly Beach",
                                                    lat: -33.797151,
                                                    lng: 151.288784,
                                                    note: nil)
}
