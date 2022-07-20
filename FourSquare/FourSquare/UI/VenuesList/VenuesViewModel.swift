//
//  VenuesViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

import Combine
import CoreLocation

final class VenuesViewModel: LoadableObject {
    private let placesSearchService: PlacesSearchServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    typealias State = LoadableData<[Venue]>
    @Published private(set) var state: State = .idle
    @Published var rachability = Reachability()
    
    init(
        placesSearchService: PlacesSearchServiceProtocol
    ) {
        self.placesSearchService = placesSearchService
        
        bind()
    }
    
    func bind() {
        placesSearchService.searchVenues(location: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), radius: 1000000)
            .sink ( receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.state = .failed(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fsResponse in
                switch fsResponse.meta.code {
                case 200:
                    guard let venues = fsResponse.response.groups?.flatMap({ $0.items.map({ $0.venue }) }) else { return }
                    
                    self?.state = venues.isEmpty ? .empty : .loaded(venues)
                case 400:
                    self?.state = .failed(NetworkError.apiError(code: 400, error: fsResponse.meta.errorDetail ?? "Error"))
                default:
                    self?.state = .failed(NetworkError.unknown(code: 400, error: "Error"))
                }
            })
            .store(in: &subscriptions)
    }
}
