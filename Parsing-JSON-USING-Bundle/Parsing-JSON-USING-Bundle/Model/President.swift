//
//  President.swift
//  Parsing-JSON-USING-Bundle
//
//  Created by Nikolai Maksimov on 19.01.2024.
//

import Foundation

struct President: Decodable, Hashable {
    let number: Int
    let name: String
    let birthYear: Int
    let deathYear: Int?
    let tookOffice: String
    let leftOffice: String?
    let party: String
    
    private enum CodingKeys: String, CodingKey {
        case number
        case name = "president"
        case birthYear = "birth_year"
        case deathYear = "death_year"
        case tookOffice = "took_office"
        case leftOffice = "left_office"
        case party
    }
}

