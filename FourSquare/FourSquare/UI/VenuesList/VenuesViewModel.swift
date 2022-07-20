//
//  VenuesViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

import Combine
import CoreLocation

final class VenuesViewModel: ObservableObject {
    private let placesSearchService: PlacesSearchServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        placesSearchService: PlacesSearchServiceProtocol
    ) {
        self.placesSearchService = placesSearchService
        
        bind()
    }
    
    func bind() {
        placesSearchService.searchVenues(location: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), radius: 500)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { response in
                print(response.response.groups.first?.items.first?.venue ?? "empty")
            }
            .store(in: &subscriptions)
    }
}
