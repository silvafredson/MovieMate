//
//  PopularMovies.swift
//  MovieMate
//
//  Created by Fredson Silva on 31/07/24.
//

import Foundation

struct PopularMovies: Codable, Identifiable {
    let originalTitle: String
    let releaseDate: String
    let genreIds: [Int]
    let overview: String
    let posterPath: String
    let id: Int
    var posterPathURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

struct PopularMoviesResponse: Codable {
    let results: [PopularMovies]
}

