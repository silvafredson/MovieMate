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
    var viewModel: PopularMoviesViewModel?
    
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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        //label.text = "Managing an exclusive list is similar. Deselect the row and display a checkmark or an accessory view to indicate the selected state. But unlike an inclusive list, limit the exclusive list to only one selected item at a time.For instance, the backpacker’s app may let users filter the list of hiking trails based on a single difficulty level: easy, moderate, and hard. With this kind of exclusive list, the app must remove the checkmark from the previous selection, and display a checkmark for the current selection. The app must also remember which item is the currently selected item. For example:"
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }
    
    func configure(movie: PopularMovies, index: IndexPath) {
        print("Overview from API: \(movie.overview)")
        backgroundImageBannerView.image = UIImage(named: movie.posterPath) // Verificar
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
    func configureMoviePoster(with movie: PopularMovies?) {
        
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
        
        overviewLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(Utils.Padding.medium)
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
                //.frame(height: 160)
                .border(Color.red)
        }
    }
}

#Preview {
    MovieDetailCellView()
}
