//
//  Environment.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    private enum Constants: String {
        case apiKey = "apiKey"
        case apiSecret = "apiSecret"
        case clientID = "clientID"
        case fatalErrorMessage = "You must supply API key and secret in the Info.plist under apiKey and spiSecret"
        case baseUrl = "https://api.foursquare.com/v3"
    }
    
    var paceSearchBaseURL: String {
        switch self {
        case .development, .staging, .production:
            return Constants.baseUrl.rawValue
        }
    }
        
    // API and Secret are stored in Configuration(XCConfig) files as we should not hard code them in the code
    
    var apiKey: String {
        guard
            let apiKey: String = Bundle.fetchValue(for: Constants.apiKey.rawValue)
        else {
            fatalError(Constants.fatalErrorMessage.rawValue)
        }
        
        return apiKey
    }
    
    var apiSecret: String {
        guard
            let apiSecret: String = Bundle.fetchValue(for: Constants.apiKey.rawValue)
        else {
            fatalError(Constants.fatalErrorMessage.rawValue)
        }
        
        return apiSecret
    }
    
    var clientID: String {
        guard
            let clientID: String = Bundle.fetchValue(for: Constants.clientID.rawValue)
        else {
            fatalError(Constants.fatalErrorMessage.rawValue)
        }
        
        return clientID
    }
}
