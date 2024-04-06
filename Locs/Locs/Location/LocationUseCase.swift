//
//  LocationUseCase.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import CoreLocation
import Combine

class LocationUseCase {

    //    private var locationRepository: LocationRepository //Do not inject the concrete class. Inject the protocol.
    
    private let locationRepository: LocationRepositoryProtocol
    
    init(locationRepository: LocationRepositoryProtocol) {
        self.locationRepository = locationRepository
    }
    
    func addCurrentLocation() -> AnyPublisher<String, Error> {
        locationRepository.addCurrentLocation()
            .map { location -> String in
                print("location: \(location)")
                return location.description
            }
            .eraseToAnyPublisher()
    }
}
