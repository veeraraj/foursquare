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
case failed
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loading, .loading),
            (.empty, .empty),
            (.failed, .failed),
            (.loaded, .loaded):
            return true
                        
        default:
            return false
            
        }
    }
}
