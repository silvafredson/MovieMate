//
//  MovieDetailViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 22/08/24.
//

import UIKit
import SwiftUI
import SnapKit

class MovieDetailViewController: UIViewController {
    
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        detailTableView.reloadData()
    }
    
    private func setupNavigationBar() {
        // Configura a barra de navegação como transparente
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear // Adiciona um fundo claro
    }
  
    private func setupView() {
        view.addSubview(detailTableView)
        detailTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.detail.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCell.identifier, for: indexPath) as? MovieDetailCell else {
            return UITableViewCell()
        }
        
        // Configura a célula com o filme selecionado
        if let selectedMovie = movie {
            print("Configurando célula para o filme: \(selectedMovie.originalTitle)")
            cell.configureMoviePoster(with: selectedMovie)
            cell.configure(movie: selectedMovie, index: indexPath)
        }
        return cell
    }
}

extension MovieDetailViewController {
    enum Sections: Int, CaseIterable {
        case detail = 1
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
