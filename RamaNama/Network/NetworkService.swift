import Combine
import Foundation

protocol NetworkServiceProvider {
    func fetch<T: Decodable>(url: URL, usingHeaders headers: [String: String]?) async throws -> Result<T, NetworkServiceError>
}

enum NetworkServiceError: Error {
    case networkError(String)
    case invalidServiceConfiguration
    case couldNotParseNetworkResponse
}

enum FetchStatus {
    case fetching
    case success
    case error(NetworkServiceError)
}

class NetworkService: NetworkServiceProvider {
    func fetch<T: Decodable>(url: URL, usingHeaders headers: [String: String]?) async throws -> Result<T, NetworkServiceError> {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = headers
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let session = URLSession(configuration: configuration)
        
        let dataResponse = try await session.data(from: url)
        
        if let response = dataResponse.1 as? HTTPURLResponse, response.statusCode > 299 {
            let errorString = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
            return .failure(.networkError(errorString))
        }
        
        let data = dataResponse.0
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.couldNotParseNetworkResponse)
        }
    }
}
