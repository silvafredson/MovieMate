//
//  PopularMoviesViewController.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {
    
    private var actorsImages: [UIImage] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.size.width * 0.42, height: view.frame.size.height * 0.22)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
        //layout.itemSize = CGSize(width: 180, height: 220)
        //layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: .zero, left: 8, bottom: .zero, right: 8)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.indentifier)
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
            actorsImages.append(UIImage(named: "Aragorn")!)
            actorsImages.append(UIImage(named: "bilbo")!)
            actorsImages.append(UIImage(named: "gand")!)
            actorsImages.append(UIImage(named: "thorin")!)
            actorsImages.append(UIImage(named: "legolas")!)
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
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (self.view.frame.width / 2) - 12
//        return CGSize(width: size, height: size)
//    }
    
    // Vertical Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // Horizontal Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

