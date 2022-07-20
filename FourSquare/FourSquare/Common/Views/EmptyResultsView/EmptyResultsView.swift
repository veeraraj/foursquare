//
//  EmptyResultsView.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

struct EmptyResultsView: View {
    let viewModel: EmptyResultsViewModel
    
    var body: some View {
        emptyResultsView()
    }
    
    @ViewBuilder
    private func emptyResultsView() -> some View {
        VStack(spacing: 0) {
            if let image = viewModel.image {
                image.swiftUIImage
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 48)
            }
            
            Text(viewModel.title)
                .multilineTextAlignment(.center)
            
            Text(viewModel.subTitle)
                .multilineTextAlignment(.center)
            
            if let didTapRetry = viewModel.retry {
                Button(viewModel.retryButtonTitle, action: { didTapRetry() })
                    .buttonStyle(PrimaryActionButton())
                    .padding(.vertical, 24)
                    .padding(.horizontal, 16)
            }
            
            Spacer()
        }
    }
}
