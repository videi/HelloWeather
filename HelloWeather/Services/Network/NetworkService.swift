import Foundation

final class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func baseRequest<T: Decodable>(
        convertible: URLRequestBuilder,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let request = convertible.asURLRequest() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch let decodingError {
                completion(.failure(.decodingError(decodingError)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case decodingError(Error)
    case noData
    case serverError(Error)
    case unknownError
}
