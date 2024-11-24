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
    
    private lazy var favoriteFlagView: UIView = {
        let flagView = UIView()
        flagView.backgroundColor = .yellow
        flagView.isHidden = true
        flagView.clipsToBounds = true
        
        // Cria a bandeira triangular com o canto superior direito arredondado
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 40, y: 10)) // Ponto inicial com ajuste para a curva
        path.addQuadCurve(to: CGPoint(x: 30, y: 0), controlPoint: CGPoint(x: 44, y: 0)) // Curva no canto superior direito
        path.addLine(to: CGPoint(x: 0, y: 0)) // Linha até a esquerda
        path.addLine(to: CGPoint(x: 40, y: 40)) // Linha até a base do triângulo
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        flagView.layer.mask = shapeLayer

        return flagView
    }()

    private lazy var favoriteIcon: UIImageView = {
        let imageVIew = UIImageView()
        imageVIew.image = UIImage(systemName: "star.fill")
        imageVIew.tintColor = .red
        imageVIew.contentMode = .scaleAspectFit
        imageVIew.isHidden = true
        return imageVIew
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: PopularMoviesModel?) {
        guard let movie = movie else {
            coverImageView.image = nil
            favoriteFlagView.isHidden = true
            return
        }
        
        if let imageURL = movie.posterPathURL {
            coverImageView.kf.setImage(with: imageURL)
        } else {
            coverImageView.image = nil
        }
        let isFavorite = FavoritesManager.shared.isFavorite(movie)
        favoriteFlagView.isHidden = !isFavorite
        favoriteIcon.isHidden = !isFavorite
        
        //favoriteFlagView.isHidden = !FavoritesManager.shared.isFavorite(movie)
    }
    
    private func setupViews() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(favoriteFlagView)
        favoriteFlagView.addSubview(favoriteIcon)
        
        coverImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        favoriteFlagView.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        favoriteIcon.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(Utils.Padding.tiny)
            $0.size.equalTo(16)
        }
    }
}
