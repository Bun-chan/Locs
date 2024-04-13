//
//  LocationManager.swift
//  Locs
//
//  Created by STEPHEN FITZGERALD on 2024/04/06.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManagerProtocol {
    var authorizationStatus: CLAuthorizationStatus { get }
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestWhenInUseAuthorization()
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
}

extension CLLocationManager: LocationManagerProtocol {}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: LocationManagerProtocol
    private let locationSubject = PassthroughSubject<CLLocation, Error>()
    
    init(locationManager: LocationManagerProtocol = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermission()
    }
    
    enum SimulationError: Error {
        case simulatedError
    }
    
    func addCurrentLocation() -> AnyPublisher<CLLocation, any Error> {
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            print("ok")
            locationManager.startUpdatingLocation()
            return locationSubject.eraseToAnyPublisher()
        } else {
            print("not allowed")
            return Fail(error: SimulationError.simulatedError)
                .eraseToAnyPublisher()
        }
    }
    
    func requestWhenInUseAuthorization() {
        
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        
    }
    
    func stopUpdatingLocation() {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted.")
//            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied.")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("shit")
        if let location = locations.last {
            locationSubject.send(location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationSubject.send(completion: .failure(error))
    }
}


