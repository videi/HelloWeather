import Foundation

extension URLRequestBuilder {
    var baseURL: String {
        "https://api.weatherapi.com"
    }
    
    func asURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: "\(baseURL)/\(path)") else { return nil }
        
        if let params = parameters {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        return request
    }
}
