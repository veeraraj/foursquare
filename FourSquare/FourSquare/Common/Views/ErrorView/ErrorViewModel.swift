//
//  ErrorViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation
import SwiftUI

struct ErrorViewModel {
    private enum Constants: String {
        case title = "Error"
        case subTitle = "Something went wrong"
        case retryButtonTitle = "Retry Now"
    }
    
    let image: UIImage?
    let title: String
    var subTitle: String
    let retryButtonTitle: String
    let retry: (() -> Void)?
    
    init(
        image: UIImage? = UIImage(named: Constants.title.rawValue.lowercased()),
        title: String = Constants.title.rawValue,
        subTitle: String = Constants.subTitle.rawValue,
        retryButtonTitle: String = Constants.retryButtonTitle.rawValue,
        retry: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.retryButtonTitle = retryButtonTitle
        self.retry = retry
    }
    
    mutating func updateSubTitle(_ errorMessage: String) {
        subTitle = errorMessage
    }
}
