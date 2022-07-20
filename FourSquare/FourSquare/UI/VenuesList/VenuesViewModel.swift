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
    private let userLocationService: UserLocationService
    private var subscriptions = Set<AnyCancellable>()
    typealias State = LoadableData<[Venue]>
    @Published private(set) var state: State = .idle
    @Published var rachability = Reachability()
    @Published var radius: Double = 600.0
    
    lazy var errorViewModel: ErrorViewModel = {
        ErrorViewModel() { [weak self] in
            self?.didTapRetryButton()
        }
    }()
    
    private(set) lazy var emptyResultsViewModel: EmptyResultsViewModel = {
        EmptyResultsViewModel() { [weak self] in
            self?.didTapRetryButton()
        }
    }()
    
    init(
        placesSearchService: PlacesSearchServiceProtocol,
        userLocationService: UserLocationService
    ) {
        self.placesSearchService = placesSearchService
        self.userLocationService = userLocationService
        
        searchForVenues()
    }
    
    func didTapRetryButton() {
        searchForVenues()
    }
    
    func bind() {
        
    }
    
    func searchForVenues() {
        state = .loading
        placesSearchService.searchVenues(location: CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041), radius: 500)
            .sink ( receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorViewModel.updateSubTitle(error.localizedDescription)
                    self?.state = .failed
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] fsResponse in
                switch fsResponse.meta.code {
                case 200:
                    guard
                        let venues = fsResponse.response.groups?.flatMap({ $0.items.map({ $0.venue }) })
                    else {
                        self?.errorViewModel.updateSubTitle(FSError.somethingWentWrong.localizedDescription)
                        self?.state = .failed
                        return
                    }
                    
                    self?.state = venues.isEmpty ? .empty : .loaded(venues)
                case 400:
                    self?.errorViewModel.updateSubTitle(fsResponse.meta.errorDetail ?? FSError.somethingWentWrong.localizedDescription)
                    self?.state = .failed
                default:
                    self?.errorViewModel.updateSubTitle(FSError.somethingWentWrong.localizedDescription)
                    self?.state = .failed
                }
            })
            .store(in: &subscriptions)
    }
}
