//
//  EmptyResultsViewModel.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation
import SwiftUI

struct EmptyResultsViewModel {
    let image: UIImage?
    let title: String
    let subTitle: String
    let retryButtonTitle: String
    let retry: (() -> Void)?
    
    init(
        image: UIImage? = UIImage(named: "empty"),
        title: String = "empty".localized,
        subTitle: String = "noResultsToShow".localized,
        retryButtonTitle: String = "retryNow".localized,
        retry: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.retryButtonTitle = retryButtonTitle
        self.retry = retry
    }
}
