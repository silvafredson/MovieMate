//
//  HomeTabContoller.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SwiftUI

final class HomeTabContoller: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        customizeTabBar()
        configureNavigationBarAppearance()
    }
    
    // MARK: - Setup Tabs
    private func setupTabs() {
        let home = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: PopularMoviesViewController())
        let favorites = self.createNav(with: "Favorites", and: UIImage(systemName: "star"), vc: FavoritesViewController())
        self.setViewControllers([home, favorites], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        //vc.additionalSafeAreaInsets = .zero
        //vc.automaticallyAdjustsScrollViewInsets = false
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = false
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        //nav.viewControllers.first?.navigationItem.title = title
        return nav
    }
    
    private func customizeTabBar() {
        self.tabBar.tintColor = Utils.SavedColors.titleAdaptiveColor
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [
            .foregroundColor: Utils.SavedColors.titleAdaptiveColor ?? .black,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}


// MARK: - SwiftUI Preview

//struct MyUIViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        // Substitua isso pelo seu próprio código para criar e configurar sua UIViewController
//        let viewController = HomeTabContoller()
//        return viewController
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            MyUIViewControllerRepresentable()
//                .edgesIgnoringSafeArea(.all)
//        }
//    }
//}
//
//// Visualização de visualização prévia
//#Preview {
//    ContentView()
//}
