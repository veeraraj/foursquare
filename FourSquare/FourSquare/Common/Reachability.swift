//
//  Reachability.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation
import Network
import Combine

enum NetworkStatus: String {
    case connected
    case disconnected
}

final class Reachability: ObservableObject {
    private let reachabilityMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")
    
    @Published var status: NetworkStatus = .connected
    
    init() {
        reachabilityMonitor.pathUpdateHandler = { [weak self] path in
            
            DispatchQueue.main.async {
                self?.status = path.status == .satisfied ? .connected : .disconnected
            }
        }
        
        reachabilityMonitor.start(queue: queue)
    }
    
    deinit {
        cancel()
    }
    
    func cancel() {
        reachabilityMonitor.cancel()
    }
}
