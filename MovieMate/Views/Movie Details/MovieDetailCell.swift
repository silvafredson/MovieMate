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
    var currentMovie: PopularMovies?
    
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
        return label
    }()
        
    private lazy var releaseDateLabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .light)
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
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }
    
    func configure(movie: PopularMovies, index: IndexPath) {
        currentMovie = movie
        print("Overview from API: \(movie.overview)")
        backgroundImageBannerView.image = UIImage(named: movie.posterPath) // Verificar
        titleLabel.text = movie.originalTitle
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.releaseDate
        // Verifica se o filme está nos favoritos e ajusta o ícone do botão
        if FavoritesManager.shared.isFavorite(movie) {
            favoriteButton.setImage(starFill, for: .normal)
        } else {
            favoriteButton.setImage(star, for: .normal)
        }
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
    
    private func favoriteButtonPressed() {
        favoriteButtonState()
        
        guard let movie = currentMovie else { return }
        
        if FavoritesManager.shared.isFavorite(movie) {
            FavoritesManager.shared.toggleFavorite(for: movie)// remove dos favoritos
            favoriteButton.setImage(star, for: .normal)
        } else {
            FavoritesManager.shared.toggleFavorite(for: movie)
            favoriteButton.setImage(starFill, for: .normal)
        }
        
        delegate?.favoriteMovie(favorite: !FavoritesManager.shared.isFavorite(movie))
    }
    
    // TODO: - A imagem de fundo não está sendo exibida corretamente
    func configureMoviePoster(with movie: PopularMovies?) {
        
        backgroundImageBannerView.image = nil
        guard let movie = movie else { return }

        if let imageURL = movie.posterPathURL { // Substitua pela URL correta
            print("URL da imagem \(imageURL)")
            backgroundImageBannerView.kf.setImage(
                with: imageURL,
                placeholder: UIImage(named: "photo.fill"), // Imagem de placeholder enquanto carrega
                options: [.transition(.fade(0.2))], // Animação de fade ao carregar
                completionHandler: { result in
                    switch result {
                    case .success:
                        print("Imagem carregada com sucesso.")
                    case .failure(let error):
                        print("Erro ao carregar imagem: \(error)")
                    }
                }
            )
        } else {
            print("URL da imagem é nil")
        }
    }
    
    private func setupViews() {
        contentView.addSubview(backgroundImageBannerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(releaseDateLabel)
        
        // Define o backgroundImageBannerView para ocupar 60% da altura
        backgroundImageBannerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            //$0.height.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(backgroundImageBannerView.snp.width).multipliedBy(1.2)
        }
        
        // Define o titleLabel abaixo da imagem
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImageBannerView.snp.bottom).offset(Utils.Padding.small)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Utils.Padding.smaller)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        // Define o overviewLabel abaixo do titleLabel
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom).offset(Utils.Padding.medium)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16) // Ajusta para alinhar o texto na parte de baixo
        }
        
        // Configuração opcional para o favoriteButton, se quiser que ele apareça junto ao título ou overview
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(24) // Define o tamanho do botão
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
