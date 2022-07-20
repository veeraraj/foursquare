//
//  Publisher+Extensions.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation
import Combine

extension Publisher {
    func unwrap<T>() -> Publishers.CompactMap<Self, T> where Output == T? {
        compactMap{ $0 }
    }
}
