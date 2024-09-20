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
        //collectionView.safeAreaInsets
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints() 
        setupBindings()
        viewModel.loadingPopularMovies()
    }
    
    private func setupBindings() {
        viewModel.$movies
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
    
    private func navigateToMovieDetail(movie: PopularMovies) {
        print("Navigating to movie detail for: \(movie.originalTitle)") // Adicione este print
        let viewController = MovieDetailViewController()
        viewController.movie = movie
        navigationController?.pushViewController(viewController, animated: true)

    }

}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedMovie = viewModel.movies[indexPath.row]
        let detailVC = MovieDetailViewController()
        detailVC.movie = selectedMovie // Passa o filme selecionado para a tela de detalhes
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movies[indexPath.row]
        print("Configuring cell with movie: \(movie.originalTitle)")
        cell.configure(with: movie)
        
        // Ação de toque na imagem
        cell.onImageTap = { [weak self] in
            self?.navigateToMovieDetail(movie: movie)
        }
        return cell
    }
    
    
//    func moviesForIndexPath(indexPath: NSIndexPath) -> PopularMovies {
//        return viewModel.movies[indexPath.row]
//        }
//        
//        
//        func reversePhotoArray(photoArray:[String], startIndex:Int, endIndex:Int){
//            if startIndex >= endIndex{
//                return
//            }
//            swap(&photosUrlArray[startIndex], &photosUrlArray[endIndex])
//            
//            reversePhotoArray(photosUrlArray, startIndex: startIndex + 1, endIndex: endIndex - 1)
//        }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width / 3) - 12
        //size = (self.view.frame.height / 3) - 90
        return CGSize(width: size, height: 180)
    }
    
    // Vertical Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
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
