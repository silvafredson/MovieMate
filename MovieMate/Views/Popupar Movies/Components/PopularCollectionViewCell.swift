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
    static let indentifier = "PopularCollectionViewCell"
    
//    private var viewModel = PopularMoviesViewModel()
//    let couverURL = URL(string: "https://image.tmdb.org/t/p/w500/hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg")
    
    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Aragorn")
        image.clipsToBounds = true
        image.layer.cornerRadius = 6
        image.layer.masksToBounds = true // Verificar se é nescessário
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(coverImageView)
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
        coverImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
