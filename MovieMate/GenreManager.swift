//
//  GenreManager.swift
//  MovieMate
//
//  Created by Fredson Silva on 18/11/24.
//

import Foundation

final class GenreManager {
    static let shared = GenreManager()
    private var genres: [Genre] = []
    
    private init() {}
    
    func setGenres(_ genres: [Genre]) {
        self.genres = genres
    }
    
    func getGenreName(for id: Int) -> String? {
        return genres.first(where: { $0.id == id })?.name
    }
    
    func getAllGenres() -> [Genre] {
        return genres
    }
}
