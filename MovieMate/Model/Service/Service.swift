//
//  Service.swift
//  MovieMate
//
//  Created by Fredson Silva on 10/08/24.
//

import Foundation

final class Service {
    let api: APIManager
    
    init(api: APIManager = API()) {
        self.api = api
    }
    
    func getPopularMovies(page: Int, completion: @escaping (Result<[PopularMovies], MoviesError>) -> Void) {
        api.request(EndPoint(path: "/movie/popular?page=\(page)")) { (result: Result<PopularMoviesResponse, MoviesError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
