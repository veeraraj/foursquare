//
//  PlacesSearchService.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation
import Combine
import CoreLocation

protocol PlacesSearchServiceProtocol {
    func searchVenues(location: CLLocationCoordinate2D, radius: Int) -> AnyPublisher<FSResponse, NetworkError>
}

class PlacesSearchService: PlacesSearchServiceProtocol {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }
    
    func searchVenues(location: CLLocationCoordinate2D, radius: Int) -> AnyPublisher<FSResponse, NetworkError> {
        let endpoint = PlacesSearchEndpoints.searchVenues(location: location, radius: radius)
        let request = endpoint.createRequest(environment: self.environment)
        return self.networkRequest.request(request)
    }
}
