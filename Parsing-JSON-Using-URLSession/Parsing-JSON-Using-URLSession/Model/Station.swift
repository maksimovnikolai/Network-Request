//
//  Station.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Nikolai Maksimov on 18.01.2024.
//

import Foundation

struct ResultsWrapper: Decodable{
    let data: StationsWrapper
}

struct StationsWrapper: Decodable {
    let stations: [Station]
}

struct Station: Decodable, Hashable {
    let name: String
    let stationType: String
    let latitude: Double
    let longitude: Double
    let capacity: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stationType = "station_type"
        case latitude = "lat"
        case longitude = "lon"
        case capacity
    }
}
