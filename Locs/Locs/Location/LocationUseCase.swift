import Foundation
import CoreLocation
import Combine

class LocationUseCase {
    
    private let locationRepository: LocationRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    public var location = PassthroughSubject<CLLocation, Never>()

    init(locationRepository: LocationRepositoryProtocol) {
        self.locationRepository = locationRepository
        setupBindings()
    }
    
    func addCurrentLocation() {
        locationRepository.addCurrentLocation()
    }
    
    private func setupBindings() {
        locationRepository.location
            .sink { value in
                print("UC \(value)")
                self.location.send(value) //Return an instance of the LocationModel.
            }
            .store(in: &cancellables)
            
    }
}
