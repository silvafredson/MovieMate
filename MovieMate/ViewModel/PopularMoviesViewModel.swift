//
//  PopularMoviesViewModel.swift
//  MovieMate
//
//  Created by Fredson Silva on 10/08/24.
//

import Foundation
import UIKit

final class PopularMoviesViewModel: ObservableObject {
    @Published var movie: [PopularMoviesModel] = []
    @Published var genres: [Genre] = []
    let service = Service()
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    private(set) var filteredMovies: [PopularMoviesModel] = []
    
    init() {
        loadGenres { [weak self] sucess in
            self?.loadPopularMovies()
        }
    }
    
    private func loadGenres(completion: @escaping (Bool) -> Void) {
        service.getGenreForMoviesDetail { [weak self] result in
            switch result {
            case .success(let genres):
                GenreManager.shared.setGenres(genres)
                print("Sucessfully loaded genres: \(genres.count) genres")
                self?.genres = genres
                completion(true)
            case .failure(let error):
                print("Failed to load genres: \(error)")
                completion(false)
            }
        }
    }
    
    func loadPopularMovies() {
        guard !isLoading else { return }
        isLoading = true
        
        print("Starting to load popular movies")
        service.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movies):
                print("Movies loaded successfully: \(movies.count) movies")
                self.movie.append(contentsOf: movies)
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
                self?.movie.append(contentsOf: movies) // Adiciona os novos filmes à lista existente
                self?.currentPage += 1
            case .failure(let error):
                print("Failed to load movies: \(error)")
            }
        }
    }
}

extension PopularMoviesViewModel {
    public func inSearchMode(_ searchController: UISearchController) -> Bool {
        let isActive = searchController.isActive
        let searchText = searchController.searchBar.text ?? ""
        
        return isActive && !searchText.isEmpty
    }
    
    public func updateSearchController(searchBarText: String?) {
        self.filteredMovies = movie
        
        if let searchText = searchBarText?.lowercased() {
            guard !searchText.isEmpty else { self.loadPopularMovies(); return } // Verificar se o método correto a se usar aqui é esse mesmo
            self.filteredMovies = self.filteredMovies.filter({ $0.originalTitle.lowercased().contains(searchText) })
        }
        self.loadPopularMovies()
    }
}
