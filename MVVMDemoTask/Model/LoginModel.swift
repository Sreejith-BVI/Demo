//
//  LoginModel.swift
//  MVVMDemoTask
//
//  Created by Akash Jain on 01/11/23.
//

import Foundation
// MARK: - CategoriesDropDown
struct Login: Codable {
    let success: Bool?
    let message, customerName, customerEmail: String?
    let mobileNumber, socialMedia: JSONNull?
    let customerID, customerToken, bannerImage, profileImage: String?
    let cartCount: Int?

    enum CodingKeys: String, CodingKey {
        case success, message, customerName, customerEmail
        case mobileNumber = "mobile_number"
        case socialMedia = "social_media"
        case customerID = "customerId"
        case customerToken, bannerImage, profileImage, cartCount
    }
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
