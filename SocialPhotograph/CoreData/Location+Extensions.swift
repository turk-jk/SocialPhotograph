//
//  Location+Extensions.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import CoreData
import CoreLocation
extension Location {
    convenience init(locationModel : LocationModel, viewContext: NSManagedObjectContext) {
        self.init(context: viewContext)
        name = locationModel.name
        lat = locationModel.lat
        lng = locationModel.lng
        note = locationModel.note ?? ""
    }
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
