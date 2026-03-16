import Foundation

protocol SplashScreenRouterDelegate: AnyObject {
    func goToMainFlow(geoLocation: GeoLocation)
}

final class SplashScreenRouter {
    weak var delegate: SplashScreenRouterDelegate?
}
