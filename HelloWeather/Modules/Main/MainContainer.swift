import UIKit

final class MainContainer {
    
    struct Dependency {
        let routerDelegate: MainRouterDelegate
        let weatherNetworkService: WeatherNetworkProtocol
    }
    
    static func build(_ dependency: Dependency, geoLocation: GeoLocation) -> UIViewController {
        let router = MainRouter()
        router.delegate = dependency.routerDelegate
        
        let presenter = MainPresenter(router: router, 
                                      weatherNetworkService: dependency.weatherNetworkService, 
                                      geoLocation: geoLocation)
        let view = MainViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
