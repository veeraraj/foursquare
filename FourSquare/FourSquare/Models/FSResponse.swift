//
//  FSResponse.swift
//  FourSquare
//
//  Created by Veera on 18/07/22.
//

import Foundation

// MARK: - FSResponse
struct FSResponse: Codable {
    let meta: Meta
    let response: Response
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let errorType: String?
    let errorDetail: String?
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case code, errorType, errorDetail
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let totalResults: Int?
    let groups: [Group]?
}

// MARK: - Group
struct Group: Codable {
    let type, name: String
    let items: [GroupItem]
}

// MARK: - GroupItem
struct GroupItem: Codable {
    let venue: Venue
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
}


// MARK: - Location
struct Location: Codable {
    let address: String?
    let distance: Int?
    let postalCode: String?
    let city: String?
    let state: String?
}

extension Venue {
    var displayName: String {
        name ?? ""
    }
    
    var address: String {
        location?.address ?? ""
    }
    
    var city: String {
        location?.city ?? ""
    }
    
    var distance: String? {
        guard let distance = location?.distance else { return nil }
        return "Distance \(distance) m"
    }
}
