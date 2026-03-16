import UIKit

final class SplashScreenContainer {
    
    struct Dependency {
        let routerDelegate: SplashScreenRouterDelegate
        let locationService: LocationServiceProtocol
    }
    
    static func build(_ dependency: Dependency) -> UIViewController {
        let router = SplashScreenRouter()
        router.delegate = dependency.routerDelegate
        
        let presenter = SplashScreenPresenter(router: router, locationService: dependency.locationService)
        let view = SplashScreenViewController(presenter: presenter)
        
        return view
    }
}
