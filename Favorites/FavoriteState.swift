//
//  FavoriteViewsOptions.swift
//  MovieMate
//
//  Created by Fredson Silva on 22/07/24.
//

import UIKit

enum FavoriteState: CaseIterable {
    case hasFavorites
    case noFavorites
    
    var switchFavoriteScreen: UIViewController {
        switch self {
        case .noFavorites:
            return NoFavoritesViewController()
        case .hasFavorites:
            return FavoritesViewController() // Placeholder até eu criar essa tela
        }
    }
}

class FavoriteViewsManeger {
    
    // MARK: - Teste de troca de tela dos Favoritos
    var favoriteState: FavoriteState = .hasFavorites
    
    var favorites: [FavoriteItem] = [] {
        didSet {
            updateFavoriteState()
        }
    }
    
    var noFavoriteState: FavoriteState = .noFavorites {
        didSet {
            
        }
    }
    
    func updateFavoriteState() {
        if favorites.isEmpty {
            favoriteState = .noFavorites
        } else {
            favoriteState = .hasFavorites
        }
    }
    
    // MARK: - Placeholders
    
    struct FavoriteItem {
        let id: Int
        let name: String
    }
}

