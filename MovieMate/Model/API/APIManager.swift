//
//  APIManager.swift
//  MovieMate
//
//  Created by Fredson Silva on 10/08/24.
//

import Foundation

protocol APIManager {
    func request<T: Codable>(_ endpoint: EndpointManager, completion: @escaping (Result <T, MoviesError>) -> Void)
}

final class API: APIManager {
    
    private let urlSession: URLSession
    
    init (urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func request<T>(_ endpoint: EndpointManager, completion: @escaping (Result<T, MoviesError>) -> Void) where T : Decodable, T : Encodable {
        
        // Verifica se o endpoint tem um URL válido.
        if let url = endpoint.url {
            
            urlSession.dataTask(with: url) { data, response, error in
                
                do {
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw MoviesError.invalidResponse
                    }
                    // Decodificação dos Dados
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let model = try decoder.decode(T.self, from: data!)
                    completion(.success(model))
                } catch {
                    completion(.failure(MoviesError.invalidData))
                }
            }.resume()
            
        } else {
            completion(.failure(MoviesError.invalidURL))
        }
    }
}
