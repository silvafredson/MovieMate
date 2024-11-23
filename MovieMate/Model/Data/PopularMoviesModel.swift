//
//  PopularMoviesModel.swift
//  MovieMate
//
//  Created by Fredson Silva on 31/07/24.
//

import Foundation

struct PopularMoviesModel: Codable, Identifiable {
    let backdropPath: String // TODO: Verificar se esse é o poster certo para imagem de fundo
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    var backdropPathURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
    
    var posterPathURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
    
    var genreNames: [String] {
        genreIds.compactMap { id in
            GenreManager.shared.getGenreName(for: id)
        }
    }
    
    enum Codingkeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id 
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

struct PopularMoviesResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [PopularMoviesModel]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [Genre]
}
