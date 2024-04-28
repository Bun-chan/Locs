import Foundation
import Combine
import CoreLocation

protocol LocationRepositoryProtocol {
    func addCurrentLocation()
    var location: PassthroughSubject<CLLocation, Never> { get }

}


class LocationRepository: LocationRepositoryProtocol {
    
    private var locationManager: LocationManager
    private var cancellables: Set<AnyCancellable> = []
    public var location = PassthroughSubject<CLLocation, Never>()

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.setupBindings()
    }
    
    func addCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func setupBindings() {
        locationManager.location
            .sink { value in
                print("repo \(value)")
                self.location.send(value)
            }
            .store(in: &cancellables)
    }
    
}
