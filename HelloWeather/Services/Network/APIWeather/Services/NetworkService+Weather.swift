import Foundation

protocol WeatherNetworkProtocol {
    func getCurrent(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
    func getForecast(lat: Double, lon: Double, days: Int, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void)
}

extension NetworkService: WeatherNetworkProtocol {
    func getCurrent(lat: Double, lon: Double, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        self.baseRequest(convertible: WeatherNetwork.Endpoint.current(lat: lat, lon: lon), completion: completion)
    }
    
    func getForecast(lat: Double, lon: Double, days: Int, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        self.baseRequest(convertible: WeatherNetwork.Endpoint.forecast(lat: lat, lon: lon, days: days), completion: completion)
    }
}
