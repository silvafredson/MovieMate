//
//  MovieDetailViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 22/08/24.
//

import UIKit
import SwiftUI
import Combine
import SnapKit

class MovieDetailViewController: UIViewController {
    
    private var viewModel = PopularMoviesViewModel()
    private var cancellables = Set<AnyCancellable>()
    var movie: PopularMovies?

    private lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isUserInteractionEnabled = true
        tableView.register(MovieDetailCell.self, forCellReuseIdentifier: MovieDetailCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailTableView)
        setupConstraints()
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.detailTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setupConstraints() {
        detailTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.identifier, for: indexPath) as? MovieDetailCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}



// MARK: - Preview SwiftUI

struct DetailUIViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Substitua isso pelo seu próprio código para criar e configurar sua UIViewController
        let viewController = MovieDetailViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct DetailView: View {
    var body: some View {
        VStack {
            DetailUIViewControllerRepresentable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

// Visualização de visualização prévia
#Preview {
    DetailView()
}
