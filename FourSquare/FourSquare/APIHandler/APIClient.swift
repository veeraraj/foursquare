//
//  APIClient.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation
import Combine

public class APIClient: Requestable {
    private enum Constants: String {
        case serverError = "Server error"
        case invalidURL = "Invalid Url"
    }
    
    public var requestTimeout: Float = 30
    
    public func request<T>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
    where T: Decodable, T: Encodable {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = TimeInterval(request.requestTimeout ?? requestTimeout)
        
        guard let url = URL(string: request.url) else {
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL(Constants.invalidURL.rawValue))
            )
        }
        
        let finalURL = request.buildURLRequest(with: url)
        return URLSession.shared
            .dataTaskPublisher(for: finalURL)
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: Constants.serverError.rawValue)
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(String(describing: error))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
