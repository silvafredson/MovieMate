//
//  FavoritesManager.swift
//  MovieMate
//
//  Created by Fredson Silva on 01/10/24.
//

import Foundation

//class FavoritesManager {
//    static let shared = FavoritesManager()
//    private var favoriteMovies: [PopularMovies] = []
//    
//    private init() {}
//
//    func addMovieToFavorites(_ movie: PopularMovies) {
//        favoriteMovies.append(movie)
//    }
//    
//    func removeMovieFromFavorites(_ movie: PopularMovies) {
//        favoriteMovies.removeAll { $0.id == movie.id }
//    }
//    
//    func isFavorite(_ movie: PopularMovies) -> Bool {
//        return favoriteMovies.contains(where: { $0.id == movie.id })
//    }
//    
//    func getFavorites() -> [PopularMovies] {
//        return favoriteMovies
//    }
//}

final class FavoritesManager {
    static var shared = FavoritesManager()
    private init() {}
    
    public private(set) var favoriteMovies: [PopularMovies] = []
    
    func toggleFavorite(for movie: PopularMovies) {
        if let index = favoriteMovies.firstIndex(where: { $0.id == movie.id }) {
            favoriteMovies.remove(at: index) // Remove dos favoritos
        } else {
            favoriteMovies.append(movie) // Adiciona aos favoritos
        }
        saveFavorites()
    }
    
    func isFavorite(_ movie: PopularMovies) -> Bool {
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }

    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(favoriteMovies) {
            UserDefaults.standard.set(encoded, forKey: "favoriteMovies")
        }
    }

    func loadFavorites() {
        if let savedMovies = UserDefaults.standard.object(forKey: "favoriteMovies") as? Data {
            let decoder = JSONDecoder()
            if let loadedMovies = try? decoder.decode([PopularMovies].self, from: savedMovies) {
                favoriteMovies = loadedMovies
            }
        }
    }
}
