//
//  PopularCollectionViewCell.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit
import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularCollectionViewCell"
    
    var onImageTap: (() -> Void)?

    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true 
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: PopularMovies?) {
        guard let movie = movie else {
            coverImageView.image = nil
            return
        }
        
        if let imageURL = movie.posterPathURL {
            coverImageView.kf.setImage(with: imageURL)
        } else {
            coverImageView.image = nil
        }
    }
    
    private func setupConstraints() {
        contentView.addSubview(coverImageView)
        
        coverImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
//    @objc private func handleImageTap() {
//        onImageTap?()
//    }
}
