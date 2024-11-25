//
//  FavoritesManager.swift
//  MovieMate
//
//  Created by Fredson Silva on 01/10/24.
//

import Foundation

final class FavoritesManager {
    static var shared = FavoritesManager()
    public var favoriteMovies: [PopularMoviesModel] = []
    
    private init() {
        loadFavorites()
    }

    func toggleFavorite(for movie: PopularMoviesModel) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: index) // Remove dos favoritos
        } else {
            favoriteMovies.append(movie) // Adiciona aos favoritos
        }
        saveFavorites()
    }
    
    func isFavorite(_ movie: PopularMoviesModel) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }

    func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteMovies) {
            UserDefaults.standard.set(encoded, forKey: "favoriteMovies")
        }
    }

    func loadFavorites() {
        if let savedMovies = UserDefaults.standard.object(forKey: "favoriteMovies") as? Data {
            let decoder = JSONDecoder()
            if let loadedMovies = try? decoder.decode([PopularMoviesModel].self, from: savedMovies) {
                favoriteMovies = loadedMovies
            }
        }
    }
}
