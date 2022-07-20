//
//  ErrorViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation
import SwiftUI

struct ErrorViewModel {    
    let image: UIImage?
    let title: String
    var subTitle: String
    let retryButtonTitle: String
    let retry: (() -> Void)?
    
    init(
        image: UIImage? = UIImage(named: "error"),
        title: String = "error".localized,
        subTitle: String = "somethingWentWrong".localized,
        retryButtonTitle: String = "retryNow".localized,
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
