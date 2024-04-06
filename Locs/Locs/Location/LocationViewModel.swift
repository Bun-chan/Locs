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
    let addLocationTapped = PassthroughSubject<Void, Never>()
    private var cancellables: Set<AnyCancellable> = []

    
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }
    
    func addCurrentLocation() {
        print("Adding location...")
        locationUseCase.addCurrentLocation()
            .sink { completion in
                print("completion :\(completion)")
            } receiveValue: { value in
                print("value :\(value)")
            }
            .store(in: &cancellables)

    }
}
