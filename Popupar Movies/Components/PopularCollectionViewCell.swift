//
//  PopularCollectionViewCell.swift
//  MovieMate
//
//  Created by Fredson Silva on 13/07/24.
//

import UIKit
import SnapKit
//import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell {
    static let indentifier = "PopularCollectionViewCell"
    
    private lazy var coverImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Aragorn")
        image.clipsToBounds = true
        image.layer.cornerRadius = Size.tiny
        image.layer.masksToBounds = true // Verificar se é nescessário
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
    
    func configure(with image: UIImage) {
        coverImageView.image = image
    }
    
    private func setupConstraints() {
        coverImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
