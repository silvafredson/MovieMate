//
//  MovieDetailCell.swift
//  MovieMate
//
//  Created by Fredson Silva on 23/08/24.
//

import UIKit
import SnapKit
import SwiftUI
import Kingfisher

protocol FavoritesMovieEventDelegate: AnyObject {
    func favoriteMovie(favorite: Bool)
}

class MovieDetailCell: UITableViewCell {
    
    weak var delegate : FavoritesMovieEventDelegate?
    
    static let identifier = "MovieDetailCell"
    private let star = UIImage(systemName: "star")
    private let starFill = UIImage(systemName: "star.fill")
    
    private lazy var backgroundImageBannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    // TODO: Mudar nome do botão
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addAction(UIAction { [weak self] _ in
            self?.favoriteButtonPressed()
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
        
    private lazy var releaseDateLabel = {
        let label = UILabel()
        return label
    }()
    
    // TODO: Estudar melhor isso
    private lazy var customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5 * 35
        view.backgroundColor = .opaqueSeparator.withAlphaComponent(0.17)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ movie: PopularMovies) {
        backgroundImageBannerView.image = UIImage(named: movie.backdropPath) // Verificar
        titleLabel.text = movie.originalTitle
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
    }
    
    // MARK: - Private functions
    private func favoriteButtonState() {
        if favoriteButton.currentImage == starFill {
            favoriteButton.setImage(star, for: .normal)
            delegate?.favoriteMovie(favorite: false)
        } else {
            favoriteButton.setImage(starFill, for: .normal)
            delegate?.favoriteMovie(favorite: true)
        }
    }
    
    // TODO: - A imagem de fundo não está sendo exibida
    func configure(with movie: PopularMovies?) {
        
        guard let movie = movie else {
            backgroundImageBannerView.image = nil
            //backgroundImageBannerView.image = UIImage(named: "Interstellar") // Apagar depois
            return
        }
        
        if let imageURL = movie.posterPathURL {
            print("Image URL: \(imageURL)")
            backgroundImageBannerView.kf.setImage(with: imageURL)
        } else {
            print("No image URL available")
            //backgroundImageBannerView.image = UIImage(named: "Interstellar")
            backgroundImageBannerView.image = nil
        }
    }
    
    private func favoriteButtonPressed() {
        favoriteButtonState()
    }
    
    private func setupView() {
        contentView.addSubview(backgroundImageBannerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(overviewLabel)
        
        backgroundImageBannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


// MARK: - SwiftUI Preview

struct MovieDetailCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let cell = MovieDetailCell()
        return cell
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct MovieDetailCellView: View {
    var body: some View {
        VStack {
            MovieDetailCellRepresentable()
                //.frame(height: 60)
                .border(Color.red)
        }
    }
}

#Preview {
    MovieDetailCellView()
}
