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
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
        //self.tabBar.backgroundColor = .darkGray
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

//extension UINavigationController {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(.red)
//        appearance.titleTextAttributes = [
//            .foregroundColor: UIColor(.black),
//            .font: UIFont.systemFont(ofSize: 30, weight: .semibold)
//        ]
//        appearance.shadowColor = .red
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        //UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
//}

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
