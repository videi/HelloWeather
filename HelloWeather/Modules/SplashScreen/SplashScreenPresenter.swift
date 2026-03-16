import Foundation

protocol SplashPresenterProtocol {
    func getLocation()
}

final class SplashScreenPresenter: SplashPresenterProtocol {
    
    // MARK: - Property

    weak var view: SplashViewProtocol?
    private let router: SplashScreenRouter
    private var locationService: LocationServiceProtocol
    
    // MARK: - Closure

    
    // MARK: - Init
    
    init(router: SplashScreenRouter, locationService: LocationServiceProtocol) {
        self.router = router
        self.locationService = locationService
    }
    
    // MARK: - Method
    func getLocation() {
        locationService.onLocationUpdate = { [weak self] geoLocation in
            self?.router.delegate?.goToMainFlow(geoLocation: geoLocation)
        }
        locationService.requestLocation()
    }
}
