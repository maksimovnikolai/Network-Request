//
//  Bundle+ParsingJSON.swift
//  Parsing-JSON-USING-Bundle
//
//  Created by Nikolai Maksimov on 19.01.2024.
//

import Foundation

enum BundleError: Error {
    case invalidResources(String)
    case noContents(String)
    case decodingError(Error)
}

extension Bundle {
    
    // 1. Получить путь к файлу для чтения использования класса Bundle => String?
    // 2. С помощью этого пути прочитать содержимое его данных => Data?
    
    func parseJSON(with name: String) throws -> [President] {
        
        guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
            throw BundleError.invalidResources(name)
        }
        
        // получение содержимого по определенному пути
        guard let data = FileManager.default.contents(atPath: path) else {
            throw BundleError.noContents(path)
        }
        
        var presidents: [President]
        
        do {
            presidents = try JSONDecoder().decode([President].self, from: data)
        } catch {
            throw BundleError.decodingError(error)
        }
        
        return presidents
    }
}
