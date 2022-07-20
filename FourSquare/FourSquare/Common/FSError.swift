//
//  FSError.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

public enum FSError: Error, Equatable {
    case somethingWentWrong
    case errorWithDescription(String)
}

extension FSError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .somethingWentWrong:
            return  "somethingWentWrong".localized
        case .errorWithDescription(let error):
            return error
        }
    }
}
