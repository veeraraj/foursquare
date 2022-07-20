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
            Text("enableLocation".localized)
            Button("goToSettings".localized, action: { viewModel.didTapOpenSettings() })
                .buttonStyle(PrimaryActionButton())
        }
        .padding(.all, 16)
    }
    @ViewBuilder
    func contentView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("adjustSearchRadius".localized)
            HStack(spacing: 8) {
                Slider(value: Binding(get: {
                    viewModel.radius
                }, set: { newVal in
                    viewModel.radius = newVal
                }),in: 600...4000,step: 1)
                    .padding(.all)
                Text("\(Int(viewModel.radius)) m")
                
                Button("search".localized, action: { viewModel.didTapSearch() })
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
                    .font(.headline).bold()
                if let address = venue.location?.address {
                    Text(address)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                if let city = venue.location?.city {
                    Text(city)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                if let distance = venue.distance {
                    Text(distance)
                        .font(.system(size: 14, weight: .bold))
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
            LoadingView(loadingText: "loading".localized)
        }
    }
    
    @ViewBuilder
    func emptyResultsView() -> some View {
        EmptyResultsView(viewModel: viewModel.emptyResultsViewModel)
    }
}
