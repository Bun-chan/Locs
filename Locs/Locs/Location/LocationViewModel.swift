//
//  LocationViewModel.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
class LocationViewModel {
    private var locationUseCase: LocationUseCase
    
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }
}
