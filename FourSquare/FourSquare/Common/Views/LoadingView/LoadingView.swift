//
//  LoadingView.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

struct LoadingView: View {
    let loadingText: String
    var body: some View {
        loadingView()
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
            
            if !loadingText.isEmpty {
                Text(loadingText)
            }
        }
    }

}
