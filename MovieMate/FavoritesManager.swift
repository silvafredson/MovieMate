//
//  FavoritesManager.swift
//  MovieMate
//
//  Created by Fredson Silva on 01/10/24.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    private var favoriteMovies: [PopularMovies] = []
    
    private init() {}

    func addMovieToFavorites(_ movie: PopularMovies) {
        favoriteMovies.append(movie)
    }
    
    func removeMovieFromFavorites(_ movie: PopularMovies) {
        favoriteMovies.removeAll { $0.id == movie.id }
    }
    
    func isFavorite(_ movie: PopularMovies) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
    
    func getFavorites() -> [PopularMovies] {
        return favoriteMovies
    }
}
