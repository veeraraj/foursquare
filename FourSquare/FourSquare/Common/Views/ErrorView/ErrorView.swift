//
//  ErrorView.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

struct ErrorView: View {
    let viewModel: ErrorViewModel
    
    var body: some View {
        errorView()
    }
    
    @ViewBuilder
    private func errorView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            if let image = viewModel.image {
                image.swiftUIImage
                    .resizable()
                    .frame(width: 150, height: 150)
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 48)
            }
            
            Text(viewModel.title)
                .multilineTextAlignment(.center)
                .padding(.vertical, 24)
            
            Text(viewModel.subTitle)
                .multilineTextAlignment(.center)
                .padding(.vertical, 24)
            
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

