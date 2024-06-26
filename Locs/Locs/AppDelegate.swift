import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let locationManager = LocationManager()
        let repository = LocationRepository(locationManager: locationManager)
        let useCase = LocationUseCase(locationRepository: repository)
        let viewModel = LocationViewModel(locationUseCase: useCase)
        
        // Initialize the view controller with the view model
        let viewController = LocationViewController(viewModel: viewModel)
        
        // Set up the window with the root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
        
        
        return true
    }

   


}

