//
//  Parsing_JSON_USING_BundleTests.swift
//  Parsing-JSON-USING-BundleTests
//
//  Created by Nikolai Maksimov on 19.01.2024.
//

import XCTest
@testable import Parsing_JSON_USING_Bundle

final class Parsing_JSON_USING_BundleTests: XCTestCase {

    // модульный тест для проверки json
    
    // 3 шага Unit test
    
    func testModel() {
        
        // 1. arrange - утверждение
        // MOK данные для проверки
        let jsonData = """
[{
        "number": 1,
        "president": "George Washington",
        "birth_year": 1732,
        "death_year": 1799,
        "took_office": "1789-04-30",
        "left_office": "1797-03-04",
        "party": "No Party"
    },
    {
        "number": 2,
        "president": "John Adams",
        "birth_year": 1735,
        "death_year": 1826,
        "took_office": "1797-03-04",
        "left_office": "1801-03-04",
        "party": "Federalist"
    }
]
""".data(using: .utf8)!
        
        let exspectedFirstPresident = "George Washington"
        
        // 2. act - действие
        do {
            let presidents = try JSONDecoder().decode([President].self, from: jsonData)
            // 3. assert - утверждение
            // является ли ожидаемое имя президента (exspectedFirstPresident) равным имени (presidents[1].name)
            XCTAssertEqual(exspectedFirstPresident, presidents[0].name)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
    
    
    func testParseJSONFromBundle() {
        // arrange
        let fileName = "presidents"
        let firstBlackPresident = "Barack Obama"
        
        // act
        do {
            let presidents = try Bundle.main.parseJSON(with: fileName)
            // assert
            // утверждение равенства
            XCTAssertEqual(firstBlackPresident, presidents[43].name)
        } catch {
            XCTFail("decoding error \(error)")
        }
    }

}
