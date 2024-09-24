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
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    func loadingPopularMovies() {
        
        guard !isLoading else { return }
        isLoading = true
        
        print("Starting to load popular movies")
        service.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movies):
                print("Movies loaded successfully: \(movies.count) movies")
                self.movies.append(contentsOf: movies)
                self.currentPage += 1
            case .failure(let error):
                print("Failed to load movies: \(error)")
            }
        }
    }
    
    func loadMorePopularMovies() {
        guard currentPage <= totalPages else {
            print("No more movies to load")
            return
        }
        
        service.getPopularMovies(page: currentPage) { [weak self] completion in
            switch completion {
            case .success(let movies):
                print("Movies loaded successfully: \(movies.count) movies")
                self?.movies.append(contentsOf: movies) // Adiciona os novos filmes à lista existente
                self?.currentPage += 1
            case .failure(let error):
                print("Failed to load movies: \(error)")
            }
        }
    }
}
