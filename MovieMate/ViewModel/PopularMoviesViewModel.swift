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
        print("Starting to load popular movies")
        service.getPopularMovies { completion in
            switch completion {
            case .success(let movies):
                print("Movies loaded successfully: \(movies.count) movies")
                self.movies = movies
            case .failure(let error):
                print("Failed to load movies: \(error)")
            }
        }
        
    }
}
