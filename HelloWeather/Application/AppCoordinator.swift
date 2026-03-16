import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    private var window: UIWindow?
    private let navigationController: UINavigationController
    
    private let weatherNetworkService: WeatherNetworkProtocol
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        
        self.weatherNetworkService = NetworkService()
    }
    
    func start() {
        let locationService = LocationService()
        let splashVC = SplashScreenContainer.build(.init(routerDelegate: self, locationService: locationService))
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }
    
    private func showMainScreen(geoLocation: GeoLocation) {
        let mainVC = MainContainer.build(.init(routerDelegate: self,
                                               weatherNetworkService: weatherNetworkService), geoLocation: geoLocation)
        
        navigationController.viewControllers = [mainVC]
        
        UIView.transition(with: window!, duration: 0.5, options: .transitionCrossDissolve) {
            self.window?.rootViewController = self.navigationController
        }
    }
}

extension AppCoordinator: SplashScreenRouterDelegate {
    func goToMainFlow(geoLocation: GeoLocation) {
        showMainScreen(geoLocation: geoLocation)
    }
}

extension AppCoordinator: MainRouterDelegate {}
