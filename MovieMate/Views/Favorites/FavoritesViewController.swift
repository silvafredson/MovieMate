//
//  FavoritesViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit
import SwiftUI

final class FavoritesViewController: UIViewController {
        
    // MARK: - No Favorite
    private lazy var noFavoritesView: UIView = {
        let view = UIView()
        let emoji = UILabel()
        emoji.text = "😅"
        emoji.font = .systemFont(ofSize: 80)
        let label = UILabel()
        label.text = "You do not have any favorites yet!"
        label.font = .systemFont(ofSize: Utils.Size.medium, weight: .regular)
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        label.textAlignment = .center
        view.addSubview(emoji)
        view.addSubview(label)
        emoji.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.equalTo(emoji.snp.bottom).offset(Utils.Padding.medium)
            $0.leading.equalToSuperview().offset(Utils.Padding.medium)
            $0.trailing.equalToSuperview().offset(-Utils.Padding.medium)
        }
        return view
    }()
    
    // MARK: - Favorite
    private lazy var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        return tableView
    }()
    
    private var favorites: [PopularMovies] = [] {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FavoritesManager.shared.loadFavorites()
        favorites = FavoritesManager.shared.favoriteMovies
        updateView() // Atualiza a tela de favoritos
    }
    
    private func setupHierarchy() {
        view.addSubview(noFavoritesView)
        view.addSubview(favoriteTableView)
    }
    
    private func setupConstraints() {
        noFavoritesView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        favoriteTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateView() {
        if favorites.isEmpty {
            noFavoritesView.isHidden = false
            favoriteTableView.isHidden = true
        } else {
            noFavoritesView.isHidden = true
            favoriteTableView.isHidden = false
        }
        favoriteTableView.reloadData()
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell()}
        
        // Configura em cada célula os dados dos favoritos
        let movie = favorites[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

// MARK: - SwiftUI Preview
//
//struct FavoritesUIViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> UIViewController {
//        // Substitua isso pelo seu próprio código para criar e configurar sua UIViewController
//        let viewController = FavoritesViewController()
//        return viewController
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//struct FavoritesContentView: View {
//    var body: some View {
//        VStack {
//            FavoritesUIViewControllerRepresentable()
//                .edgesIgnoringSafeArea(.all)
//        }
//    }
//}
//
//// Visualização de visualização prévia
//#Preview {
//    FavoritesContentView()
//}
