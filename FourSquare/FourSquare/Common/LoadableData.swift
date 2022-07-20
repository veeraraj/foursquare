//
//  LoadableData.swift
//  FourSquare
//
//  Created by Veera on 20/07/22.
//

import Foundation

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadableData<Output> { get }
}

enum LoadableData<Value>: Equatable {
case idle
case loading
case empty
case loaded(Value)
case failed(Error)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading),
            (.empty, .empty),
            (.loaded, .loaded):
            return true
            
        case (.failed(let lValue), .failed(let rValue)):
            return lValue.localizedDescription == rValue.localizedDescription
            
        default:
            return false
            
        }
    }
}
