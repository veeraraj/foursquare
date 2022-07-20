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
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let totalResults: Int
    let groups: [Group]
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
    let id, name: String
    let location: Location
    let categories: [Category]
    let photos: Photos
    let venuePage: VenuePage?
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String
    let suffix: Suffix

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

enum Suffix: String, Codable {
    case png = ".png"
}

// MARK: - Location
struct Location: Codable {
    let address: String
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode: String?
    let cc: String?
    let city: String?
    let state: String?
    let country: String?
    let formattedAddress: [String]
    let crossStreet, neighborhood: String?
}


// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: Label
    let lat, lng: Double
}

enum Label: String, Codable {
    case display = "display"
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
}

// MARK: - VenuePage
struct VenuePage: Codable {
    let id: String
}

// MARK: - Ne
struct Ne: Codable {
    let lat, lng: Double
}
