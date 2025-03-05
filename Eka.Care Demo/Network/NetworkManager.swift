//
//  NetworkManager.swift
//  Eka.Care Demo
//
//  Created by Varun Adit on 3/4/25.
//

import Combine
import Foundation

enum NetworkError: LocalizedError {
    case urlError
    case decodingError
    case badResponse
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "Invalid URL"
        case .decodingError:
            return "Failed to decode data"
        case .badResponse:
            return "Bad response from the server"
        case .other(let error):
            return error.localizedDescription
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .urlError:
            return "Please check the URL and try again."
        case .decodingError:
            return "The data received from the server may be corrupted, or the format of the data is incorrect."
        case .badResponse:
            return "Status Code from server is not in 2xx range. Please try again later."
        case .other:
            return nil
        }
    }
    
}

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    private init() {
        
    }
    
    func fetch<T>(_ endpoint: Endpoint, for modelType: T.Type) -> AnyPublisher<T, NetworkError> where T : Decodable {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.endpoint).appending(queryItems: endpoint.queryItems)
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200...300 ~= httpResponse.statusCode else {
                    throw NetworkError.badResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let _ = error as? DecodingError {
                    return .decodingError
                } else if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return .other(error)
                }
            }
            .eraseToAnyPublisher()
        
    }
}
