//
//  Parsing_JSON_Using_URLSessionTests.swift
//  Parsing-JSON-Using-URLSessionTests
//
//  Created by Nikolai Maksimov on 18.01.2024.
//

import XCTest
@testable import Parsing_JSON_Using_URLSession

final class Parsing_JSON_Using_URLSessionTests: XCTestCase {
    
    func testModel() {
        let jsonData = """
    {
        "data": {
            "stations": [{
                    "external_id": "1854538387432581604",
                    "station_id": "1854538387432581604",
                    "rental_uris": {
                        "ios": "https://bkn.lft.to/lastmile_qr_scan",
                        "android": "https://bkn.lft.to/lastmile_qr_scan"
                    },
                    "station_type": "classic",
                    "eightd_station_services": [],
                    "rental_methods": [
                        "KEY",
                        "CREDITCARD"
                    ],
                    "electric_bike_surcharge_waiver": false,
                    "short_name": "6255.02",
                    "lat": 40.74535,
                    "has_kiosk": true,
                    "lon": -73.8558,
                    "name": "49 Ave & 108 St",
                    "capacity": 0,
                    "eightd_has_key_dispenser": false
                },
                {
                    "external_id": "1849010133527040242",
                    "station_id": "1849010133527040242",
                    "rental_uris": {
                        "ios": "https://bkn.lft.to/lastmile_qr_scan",
                        "android": "https://bkn.lft.to/lastmile_qr_scan"
                    },
                    "station_type": "classic",
                    "eightd_station_services": [],
                    "rental_methods": [
                        "KEY",
                        "CREDITCARD"
                    ],
                    "electric_bike_surcharge_waiver": false,
                    "short_name": "6448.07",
                    "lat": 40.75147,
                    "has_kiosk": true,
                    "lon": -73.8557,
                    "name": "111 St & Roosevelt Ave",
                    "capacity": 0,
                    "eightd_has_key_dispenser": false
                }
            ]
        }
    }
    """.data(using: .utf8)!
        
        let expectedCapacity = 0
        
        do {
            let results = try JSONDecoder().decode(ResultsWrapper.self, from: jsonData)
            let stations = results.data.stations // [Station]
            let firstStation = stations[0]
            // assert
            XCTAssertEqual(expectedCapacity, firstStation.capacity)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
}
