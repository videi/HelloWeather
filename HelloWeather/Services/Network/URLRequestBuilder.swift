import Foundation

protocol URLRequestBuilder {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}
