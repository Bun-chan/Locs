//
//  LocationUseCase.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
class LocationUseCase {
    private var locationRepository: LocationRepository
    
    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }
}
