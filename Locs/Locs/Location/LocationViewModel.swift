//
//  LocationViewModel.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import Combine

class LocationViewModel {
    
    private var locationUseCase: LocationUseCase
    private var cancellables: Set<AnyCancellable> = []

    
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }
    
    func addCurrentLocation() {
        print("Adding location...")
        cancellables.removeAll()
        locationUseCase.addCurrentLocation()
            .sink { completion in
                print("VM completion :\(completion)")
            } receiveValue: { value in
                print("VM value :\(value)")
            }
            .store(in: &cancellables)
    }
}
