//
//  HomeTabContoller.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit

final class HomeTabContoller: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    // MARK: - Setup Tabs
    private func setupTabs() {
        
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: PopularMoviesViewController())
        let favorites = self.createNav(with: "Favorites", and: UIImage(systemName: "star"), vc: FavoritesViewController())
        
        self.setViewControllers([home, favorites], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
}
