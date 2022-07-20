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
            HStack {
                Slider(value: Binding(get: {
                           viewModel.radius
                       }, set: { newVal in
                           viewModel.radius = newVal
                       }),in: 600...4000,step: 1)
                       .padding(.all)
                Text("\(Int(viewModel.radius)) m")
            }
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
                contentView(venues)
            }
        }
    }
    
    @ViewBuilder
    func contentView(_ venues: [Venue]) -> some View {
        List(venues, id: \.id) { venue in
            LazyVStack(alignment: .leading, spacing: 8) {
                Text(venue.name)
                Text(venue.location.address)
                Text(venue.location.city ?? "")
                Text("\(venue.location.distance) m")
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
