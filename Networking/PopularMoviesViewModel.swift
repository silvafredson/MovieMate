//
//  PopularMoviesViewModel.swift
//  MovieMate
//
//  Created by Fredson Silva on 10/08/24.
//

import Foundation

final class PopularMoviesViewModel: ObservableObject {
    @Published var movies: [PopularMovies] = []
    let service = Service()
    
    func loadingPopularMovies() {
        service.getPopularMovies { completion in
            switch completion {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
