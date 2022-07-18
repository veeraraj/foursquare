//
//  Bundle+Extensions.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation

extension Bundle {
    static func fetchValue<T>(for key: String) -> T? {
        main.infoDictionary?[key] as? T
    }
}
