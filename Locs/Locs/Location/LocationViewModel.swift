import Foundation
import Combine

class LocationViewModel {
    
    private var locationUseCase: LocationUseCase
    private var cancellables: Set<AnyCancellable> = []
    public var locationAdded = PassthroughSubject<Bool, Never>()
    
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
        self.setupBindings()
    }
    
    func addCurrentLocation() {
        locationUseCase.addCurrentLocation()
    }
    
    private func setupBindings() {
        locationUseCase.location
            .sink { value in
                print("VM \(value)") //A locationModel instance will be returned. On the VC what do I want to show? Success. Or on the map show a pin.
                //if the location was successfully added, return true and show a pop up to let the user know it was added.
                self.locationAdded.send(true)
            }
            .store(in: &cancellables)
            
    }
}
