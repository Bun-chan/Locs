//
//  LocationModel.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import CoreLocation
import UIKit

class Location {
    var location: CLLocation //lat, long.
    var name: String?
    var group: String? //Group like locs together. RecordStore group, izakaya group, yakitori group. This will be used when fetching from CoreData.
    var images: [UIImage]?
    var description: String? //Enter a description about the loc.
    
    init(location: CLLocation) {
        self.location = location
    }
}
