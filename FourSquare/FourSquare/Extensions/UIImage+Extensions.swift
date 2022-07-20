//
//  UIImage+Extensions.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import SwiftUI

extension UIImage {
    var swiftUIImage: SwiftUI.Image {
        SwiftUI.Image(uiImage: self)
    }
}
