//
//  Venue.swift
//  VenuesTask
//
//  Created by Ibtikar on 13/12/2022.
//

import Foundation

// MARK: - ServerResponse
struct ServerResponse<T: Codable>: Codable {
    let meta: Meta?
    let response: T?
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int?
    let requestID: String?

    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct VenuesResponse: Codable {
    let venues: [Venue]?
    let confident: Bool?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
    let categories: [Category]?
    let referralID: String?
    let hasPerk: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, location, categories
        case referralID = "referralId"
        case hasPerk
    }
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String?
    let icon: Icon?
    let primary: Bool?
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String?
    let suffix: String?

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

// MARK: - Location
struct Location: Codable {
    let address, crossStreet: String?
    let lat, lng: Double?
    let labeledLatLngs: [LabeledLatLng]?
    let distance: Int?
    let countryShortCut: String?
    let city, state: String?
    let country: String?
    let formattedAddress: [String]?
    let postalCode: String?
    
    enum CodingKeys: String, CodingKey {
        case address, crossStreet, lat, lng, labeledLatLngs, distance
        case countryShortCut = "cc"
        case city, state, country, formattedAddress, postalCode
    }
}

// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String?
    let lat, lng: Double?
}
