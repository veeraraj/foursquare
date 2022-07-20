//
//  VenuesView.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

struct VenuesView: View {
    @ObservedObject var viewModel: VenuesViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLocationAccessEnabled {
                contentView()
            } else {
                locationPermissionSoftLandingView()
            }
        }
        .frame(alignment: .top)
    }
    
    @ViewBuilder
    func locationPermissionSoftLandingView() -> some View {
        VStack(spacing: 32) {
            Text("Please enable location")
            Button("Go to settings", action: { viewModel.didTapOpenSettings() })
                .buttonStyle(PrimaryActionButton())
        }
        .padding(.all, 16)
    }
    @ViewBuilder
    func contentView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Adjust search radius")
            HStack(spacing: 8) {
                Slider(value: Binding(get: {
                    viewModel.radius
                }, set: { newVal in
                    viewModel.radius = newVal
                }),in: 600...4000,step: 1)
                    .padding(.all)
                Text("\(Int(viewModel.radius)) m")
                
                Button("Search", action: { viewModel.didTapSearch() })
                    .buttonStyle(PrimaryActionButton())
                    .frame(maxWidth: 100, maxHeight: 40)
            }
        }
        .padding(.all, 16)
        
        Spacer()
        
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            loadingView()
        case .failed:
            errorView()
        case .empty:
            emptyResultsView()
        case .loaded(let venues):
            venuesView(venues)
        }
        
        Spacer()
    }
    
    @ViewBuilder
    func venuesView(_ venues: [Venue]) -> some View {
        List(venues, id: \.id) { venue in
            LazyVStack(alignment: .leading, spacing: 8) {
                Text(venue.displayName)
                if let address = venue.location?.address {
                    Text(address)
                }
                
                if let city = venue.location?.city {
                    Text(city)
                }
                
                if let distance = venue.distance {
                    Text(distance)
                }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    func errorView() -> some View {
        ErrorView(viewModel: viewModel.errorViewModel)
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            LoadingView(loadingText: "Loading")
        }
    }
    
    @ViewBuilder
    func emptyResultsView() -> some View {
        EmptyResultsView(viewModel: viewModel.emptyResultsViewModel)
    }
}
