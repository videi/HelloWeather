import Foundation

enum WeatherNetwork {
    
    enum Endpoint: URLRequestBuilder {
        case current(lat: Double, lon: Double)
        case forecast(lat: Double, lon: Double, days: Int)

        private var apiKey: String { "fa8b3df74d4042b9aa7135114252304" }

        var path: String {
            switch self {
            case .current:
                return "v1/current.json"
            case .forecast:
                return "v1/forecast.json"
            }
        }

        var parameters: [String : String]? {
            var params = ["key": apiKey]
            
            switch self {
            case .current(let lat, let lon):
                params["q"] = "\(lat),\(lon)"
            case .forecast(let lat, let lon, let days):
                params["q"] = "\(lat),\(lon)"
                params["days"] = "\(days)"
            }
            return params
        }

        var method: String {
            return "GET"
        }

        var headers: [String : String]? {
            return ["Content-Type": "application/json"]
        }
    }
}
