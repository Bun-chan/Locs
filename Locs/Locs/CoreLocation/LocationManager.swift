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
    public var location = PassthroughSubject<CLLocation, Never>()
    @Published private(set) var authorizationStatus: CLAuthorizationStatus
    private var hasStartedUpdatingLocation = false
    private var startUpdateLocationTime: Date?

    
    init(locationManager: LocationManagerProtocol = CLLocationManager()) {
        self.locationManager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus

        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func startUpdatingLocation() {
        //MARK: first check the auth status and then call start...
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted.")
        case .denied, .restricted:
            print("Location access denied.")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if hasStartedUpdatingLocation == false {
            startUpdateLocationTime = Date()
            hasStartedUpdatingLocation = true
        } else {
            if let tempStartUpdateLocationTime = startUpdateLocationTime {
                if Date().timeIntervalSince(tempStartUpdateLocationTime) > 2.0 {
                    stopUpdatingLocation()
                    print("LOC: \(String(describing: locations.last))")
                    if let loc = locations.last {
                        location.send(loc)
                    }
                    hasStartedUpdatingLocation = false
                    startUpdateLocationTime = nil
                }
            }
        }
    }
}


