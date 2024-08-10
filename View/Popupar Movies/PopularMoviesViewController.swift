//
//  PopularMoviesViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit
import SwiftUI

class PopularMoviesViewController: UIViewController {
    
    private var actorsImages: [UIImage] = []
    
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
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.indentifier)
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        setupConstraints() 
        setupActorsImages()
    }
    
    
    //MARK: - place holder
    private func setupActorsImages() {
        for _ in 0...25 {
            actorsImages.append(UIImage(named: "The Dark Knight")!)
            actorsImages.append(UIImage(named: "Interstellar")!)
            actorsImages.append(UIImage(named: "Inception")!)
        }
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actorsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.indentifier, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        let actorsImages = self.actorsImages[indexPath.row]
        cell.configure(with: actorsImages)
        return cell
    }
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
    
//    // Horizontal Spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 14
//    }
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
