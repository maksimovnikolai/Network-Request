//
//  APIClient.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Nikolai Maksimov on 18.01.2024.
//

import Foundation


// TODO: convert to a Generic APIClient<Station>()
// conform APIClient to Decodable

enum APIError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient {
    
    // метод fetchData() выполняет асинхронный сетевой вызов
    // это означает, что метод возвращает (ДО) запрос завершен
    
    // при работе с асинхронными вызовами мы используем замыкание,
    // другие механизмы, которые можно использовать, включают: делегирование, NotificationCenter,
    // начиная с iOS 13 новинкой является (Combine)
    
    // замыкания фиксируют значения, это ссылочный тип
    
    func fetchData(completion: @escaping (Result<[Station], APIError>) -> Void) {
      
        // "prospekt park".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        // 1.
        // url-адрес для обращения к серверу
        guard let url = URL(string: Api.endPoint) else {
            completion(.failure(.badURL(Api.endPoint)))
            return
        }
        
        // 2. создать запрос GET, другие примеры запросов POST, DELETE, PATCH, PUT
        let request = URLRequest(url: url)
        
        // request.httpMethod = "GET"
        // request.httpBody = data
        // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 3. используем URLSession для выполнения сетевого запроса
        // URLSession.shared - это singleton
        // этого достаточно для выполнения большинства запросов
        // использование URLSession без общего экземпляра дает доступ
        // для добавления необходимых конфигураций в вашу задачу
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let data = data {
                
                // 4.декодировать JSON в нашу модель Swift
                do {
                    let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    completion(.success(results.data.stations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
