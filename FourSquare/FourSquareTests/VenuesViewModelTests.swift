//
//  VenuesViewModelTests.swift
//  FourSquareTests
//
//  Created by Veera on 20/07/22.
//

import XCTest
import CoreLocation
import SwiftyMocky
import Combine
@testable import FourSquare


class VenuesViewModelTests: XCTestCase {
    
    private var placesSearchService: PlacesSearchServiceProtocolMock!
    private var userLocationService: UserLocationService!
    override func setUp() {
        super.setUp()
        placesSearchService = PlacesSearchServiceProtocolMock()
        userLocationService = UserLocationService.live
    }
    
    override func tearDown() {
        placesSearchService = nil
        userLocationService = nil
        super.tearDown()
    }
    
    func testEmptyResults() throws {
        Given(placesSearchService, .searchVenues(location: .any, radius: .any, willReturn: mockResponseEmpty()))
                
        let viewModel = VenuesViewModel(placesSearchService: placesSearchService, userLocationService: userLocationService)
        viewModel.isLocationAccessEnabled = true
        viewModel.didTapSearch()
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            XCTAssertEqual(viewModel.state, .empty)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func testResults() throws {
        Given(placesSearchService, .searchVenues(location: .any, radius: .any, willReturn: mockResponseResults()))
                
        let viewModel = VenuesViewModel(placesSearchService: placesSearchService, userLocationService: userLocationService)
        viewModel.isLocationAccessEnabled = true
        viewModel.didTapSearch()
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            XCTAssertEqual(viewModel.state, .loaded([self.venue()]))
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    func testError() throws {
        Given(placesSearchService, .searchVenues(location: .any, radius: .any, willReturn: mockError()))
                
        let viewModel = VenuesViewModel(placesSearchService: placesSearchService, userLocationService: userLocationService)
        viewModel.isLocationAccessEnabled = true
        viewModel.didTapSearch()
        
        let expect = XCTestExpectation(description: "test")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            XCTAssertEqual(viewModel.state, .failed)
            expect.fulfill()
        })
        
        wait(for: [expect], timeout: 3.0)
    }
    
    // MARK: Mock data
    private func mockResponseEmpty() -> AnyPublisher<FSResponse, NetworkError> {
        let currentValueSubject: CurrentValueSubject<FSResponse, NetworkError> =
            .init(FSResponse(meta: Meta(code: 200, errorType: nil, errorDetail: nil, requestID: "12346"), response: Response(totalResults: 0, groups: [])))
        
        return currentValueSubject.eraseToAnyPublisher()
    }
    
    private func mockResponseResults() -> AnyPublisher<FSResponse, NetworkError> {
        let currentValueSubject: CurrentValueSubject<FSResponse, NetworkError> =
            .init(FSResponse(meta: Meta(code: 200, errorType: nil, errorDetail: nil, requestID: "12346"), response: Response(totalResults: 0, groups: [Group(type: "Test type", name: "Test group", items: [GroupItem(venue: Venue(id: "123", name: "Test venue", location: Location(address: "test address", distance: 100, postalCode: "1234AB", city: "Test city", state: nil)))])])))
        
        return currentValueSubject.eraseToAnyPublisher()
    }
    
    private func mockError() -> AnyPublisher<FSResponse, NetworkError> {
        let currentValueSubject: CurrentValueSubject<FSResponse, NetworkError> = .init(FSResponse(meta: Meta(code: 400, errorType: "Test", errorDetail: "Test error", requestID: "456"), response: Response(totalResults: 0, groups: [])))
        return currentValueSubject.eraseToAnyPublisher()
    }
    
    private func venue() -> Venue {
        Venue(id: "123", name: "Test venue", location: Location(
            address: "test address", distance: 100, postalCode: "1234AB", city: "Test city", state: nil
        ))
    }
}
