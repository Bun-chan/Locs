//
//  LocationRepository.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import Combine
import CoreLocation

protocol LocationRepositoryProtocol {
    func addCurrentLocation() -> AnyPublisher<CLLocation, Error>
}


class LocationRepository: LocationRepositoryProtocol {
    
//    private var locationUseCase: LocationUseCase
    private var locationManager: LocationManager
    private var cancellables: Set<AnyCancellable> = []

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }
    
    func addCurrentLocation() -> AnyPublisher<CLLocation, Error> {
        return locationManager.currentLocationPublisher()
    }
    
}
