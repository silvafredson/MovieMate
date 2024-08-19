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
        //layout.itemSize = .init(width: view.frame.size.width * 0.42, height: view.frame.size.height * 0.22)
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        //layout.itemSize = CGSize(width: 180, height: 220)
        //layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.safeAreaInsets
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.indentifier)
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
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.indentifier, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movies[indexPath.row]
        print("Configuring cell with movie: \(movie.originalTitle)")
        cell.configure(with: movie)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Movie \(indexPath.row) tepped")
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
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    PopularMoviesView()
}
