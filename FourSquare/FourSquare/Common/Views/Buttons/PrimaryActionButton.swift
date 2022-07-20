//
//  PrimaryActionButton.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

struct PrimaryActionButton: ButtonStyle {
    private let image: Image?
    
    init(image: Image? = nil) {
        self.image = image
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 0) {
            
            image?
                .renderingMode(.template)
                .foregroundColor(.black)
                .frame(width: 20, height: 20)
            
            configuration.label
                .frame(height: 48)
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .frame(maxWidth:.infinity)
            
            Spacer()
        }
        .padding(.horizontal, 25)
        .background(
            configuration.isPressed ? .gray : .blue
        )
        .cornerRadius(8)
    }
}
