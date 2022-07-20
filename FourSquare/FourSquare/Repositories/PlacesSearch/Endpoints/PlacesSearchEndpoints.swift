//
//  PlacesSearchEndpoints.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation
import CoreLocation

enum PlacesSearchEndpoints {
    
    case searchVenues(location: CLLocationCoordinate2D, radius: Int)
    
    func createRequest(environment: Environment) -> NetworkRequest {
        let queryParams = buildQueryParams(for: environment)
        
        return NetworkRequest(url: getURL(from: environment), headers: ["Accept": "application/json"], httpMethod: httpMethod, queryParams: queryParams)
    }
    
    private var requestTimeOut: Int {
        return 20
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        case .searchVenues:
            return .GET
        }
    }
    
    private func getURL(from environment: Environment) -> String {
        let baseUrl = environment.placeSearchBaseURL
        switch self {
        case .searchVenues:
            return baseUrl + "/venues/explore/"
        }
    }
    
    private func buildQueryParams(for environment: Environment) -> QueryParams {
        switch self {
        case let .searchVenues(location, radius):
            return [
                "client_id": environment.clientID,
                "client_secret": environment.clientSecret,
                "ll": "\(location.latitude),\(location.longitude)",
                "radius": "\(radius)",
                "v":  environment.version
            ]
        }
    }
}
