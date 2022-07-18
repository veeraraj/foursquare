//
//  Requestable.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation
import Combine

public protocol Requestable {
    var requestTimeout: Float { get }
    
    func request<T: Codable>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
