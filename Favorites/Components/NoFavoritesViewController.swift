//
//  NoFavoritesViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 21/07/24.
//

import UIKit
import SnapKit
import SwiftUI

class NoFavoritesViewController: UIViewController {
    
    private lazy var emoji: UILabel = {
        let image = UILabel()
        image.text = "😅"
        image.font = .systemFont(ofSize: 120)
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "You do not have any favorites yet!"
        label.font = .systemFont(ofSize: Size.big, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupHierarchy()
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        view.addSubview(emoji)
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        emoji.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(emoji.snp.bottom).offset(Padding.medium)
            $0.trailing.leading.equalToSuperview()
        }
    }
    
}

 // MARK: - SwiftUI Preview

//struct MyUIViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        // Substitua isso pelo seu próprio código para criar e configurar sua UIViewController
//        let viewController = NoFavoritesViewController()
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
