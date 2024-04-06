//
//  LocationManager.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocation, Error>()
    private var authorizationSubject = PassthroughSubject<CLAuthorizationStatus, Never>()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    private func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }

    func authorizationPublisher() -> AnyPublisher<CLAuthorizationStatus, Never> {
        requestAuthorization()
        return authorizationSubject.eraseToAnyPublisher()
    }

    func currentLocationPublisher() -> AnyPublisher<CLLocation, Error> {
        print("currentLocationPublisher")
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationSubject
            .handleEvents(receiveCancel: { [weak self] in
                self?.locationManager.stopUpdatingLocation()
            })
            .eraseToAnyPublisher()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationSubject.send(status)
        print("status \(status)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations \(locations)")
        if let location = locations.first {
            locationSubject.send(location)
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.send(completion: .failure(error))
        print("error \(error)")
    }
}
