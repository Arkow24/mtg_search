//
//  Card.swift
//  MtG Search
//
//  Created by Arkow on 15/07/2022.
//

import Foundation

struct Card: Decodable, Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.name == rhs.name && lhs.imageUrls.small == rhs.imageUrls.small && lhs.oracleText == rhs.oracleText && lhs.typeLine == rhs.typeLine && lhs.manaCost == rhs.manaCost
    }
    
    let name: String
    let imageUrls: Images
    let manaCost: String
    let typeLine: String
    let oracleText: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case imageUrls = "image_uris"
        case manaCost = "mana_cost"
        case typeLine = "type_line"
        case oracleText = "oracle_text"
    }
}

struct Images: Decodable {
    let small: URL
}

struct DataAll: Decodable {
    let data: [Card]
}
