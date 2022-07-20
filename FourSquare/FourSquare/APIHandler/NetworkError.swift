//
//  NetworkError.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation

public enum NetworkError: Error, Equatable {
case badURL(_ error: String)
case apiError(code: Int, error: String)
case invalidJSON(_ error: String)
case unauthorized(code: Int, error: String)
case badRequest(code: Int, error: String)
case serverError(code: Int, error: String)
case noResponse(_ error: String)
case unableToParseData(_ error: String)
case unknown(code: Int, error: String)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL(let error):
            return error
        case .apiError(_, let error):
            return error
        case .invalidJSON(let error):
            return error
        case .unauthorized(_, let error):
            return error
        case .badRequest(_, let error):
            return error
        case .serverError(_, let error):
            return error
        case .noResponse(let error):
            return error
        case .unableToParseData(let error):
            return error
        case .unknown(_, let error):
            return error
        }
    }
}
