import CoreLocation

struct GeoLocation {
    let latitude: Double
    let longitude: Double
}

protocol LocationServiceProtocol {
    var onLocationUpdate: ((GeoLocation) -> Void)? { get set }
    func requestLocation()
}

final class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    private let manager = CLLocationManager()
    
    private(set) var defaultCoordinate = GeoLocation(latitude: 55.7558, longitude: 37.6173)
    
    var onLocationUpdate: ((GeoLocation) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            onLocationUpdate?(defaultCoordinate)
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            onLocationUpdate?(defaultCoordinate)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            onLocationUpdate?(defaultCoordinate)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else {
            onLocationUpdate?(defaultCoordinate)
            return
        }
        manager.stopUpdatingLocation()
        onLocationUpdate?(GeoLocation(latitude: location.latitude, longitude: location.longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onLocationUpdate?(defaultCoordinate)
    }
}
