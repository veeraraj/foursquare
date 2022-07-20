//
//  String+Extensions.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "\(self)_comment")
    }
}
