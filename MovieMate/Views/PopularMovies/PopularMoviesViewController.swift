//
//  PopularMoviesViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit
import SwiftUI
import Combine

class PopularMoviesViewController: UIViewController {
    
    private var viewModel = PopularMoviesViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints() 
        setupBindings()
    }
    
    // TODO: - Vrificar se é necessário chamar o loadingPopularMovies() aqui ou no viewDidLoad()
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadPopularMovies()
    }
    
    private func setupBindings() {
        viewModel.$movie
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    // TODO: - Resolver o problema da safe area
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func navigateToMovieDetail(movie: PopularMoviesModel) {
        print("Navigating to movie detail for: \(movie.originalTitle)") // Adicione este print
        let viewController = PopularMovieDetailViewController()
        viewController.movie = movie
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedMovie = viewModel.movie[indexPath.row]
        let detailVC = PopularMovieDetailViewController()
        detailVC.movie = selectedMovie // Passa o filme selecionado para a tela de detalhes
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movie[indexPath.row]
        print("Configuring cell with movie: \(movie.originalTitle)")
        cell.configure(with: movie)
        
        // Ação de toque na imagem
        cell.onImageTap = { [weak self] in
            self?.navigateToMovieDetail(movie: movie)
        }
        return cell
    }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width / 3) - 12
        return CGSize(width: size, height: 180)
    }
    
    // Vertical Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension PopularMoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let currentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Verifica se o usuário está a 100 pontos do final da lista
        if offsetY > currentHeight - height {
            viewModel.loadMorePopularMovies()
        }
    }
}

// MARK: - SwiftUI Preview

struct PopularMoviesViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Substitua isso pelo seu próprio código para criar e configurar sua UIViewController
        let viewController = PopularMoviesViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct PopularMoviesView: View {
    var body: some View {
        VStack {
            PopularMoviesViewControllerRepresentable()
                //.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    PopularMoviesView()
}
