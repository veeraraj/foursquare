//
//  FourSquareApp.swift
//  FourSquare
//
//  Created by Veera on 17/07/22.
//

import SwiftUI

@main
struct FourSquareApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = VenuesViewModel(placesSearchService: PlacesSearchService(networkRequest: APIClient(), environment: .development), userLocationService: UserLocationService.live)
            VenuesView(viewModel: viewModel)
        }
    }
}
