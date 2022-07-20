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
            switch viewModel.state {
            case .idle:
                Text("idle")
            case .loading:
                Text("loading")
            case .failed(let error):
                Text(error.localizedDescription)
            case .empty:
                Text("idles")
            case .loaded(let venues):
                Text("\(venues.count)")
            }
        }
    }
}
