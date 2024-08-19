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
    
    func getPopularMovies(completion: @escaping (Result<[PopularMovies], MoviesError>) -> Void) {
        api.request(EndPoint(path: "/movie/popular")) { (result: Result<PopularMoviesResponse, MoviesError>) in
            completion(result.map{ $0.results })
        }
    }
}
