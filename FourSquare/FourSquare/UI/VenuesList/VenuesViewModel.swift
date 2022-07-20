//
//  VenuesViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

import Combine
import CoreLocation
import UIKit

final class VenuesViewModel: LoadableObject {
    private let placesSearchService: PlacesSearchServiceProtocol
    private let userLocationService: UserLocationService
    private var subscriptions = Set<AnyCancellable>()
    typealias State = LoadableData<[Venue]>
    @Published private(set) var state: State = .idle
    @Published var rachability = Reachability()
    @Published var radius: Double = 600.0
    @Published var isLocationAccessEnabled: Bool = false
    
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
        
        bind()
    }
    
    func didTapRetryButton() {
        searchForVenues()
    }
    
    func didTapSearch() {
        searchForVenues()
    }
    
    func didTapOpenSettings() {
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
    
    func bind() {
        _ = userLocationService.currentUserLocation()
        userLocationService
            .didChangeAuthorization
            .removeDuplicates()
            .sink(receiveValue: { [weak self] authorization in
                switch authorization {
                case .authorizedAlways, .authorizedWhenInUse:
                    self?.isLocationAccessEnabled = true
                default:
                    self?.isLocationAccessEnabled = false
                }
            })
            .store(in: &subscriptions)
    }
    
    func searchForVenues() {
        guard let location =  userLocationService.currentUserLocation() else { return }
                
        state = .loading
        placesSearchService.searchVenues(location: location, radius: Int(radius))
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
