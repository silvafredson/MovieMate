//
//  FavoritesTableViewCell.swift
//  MovieMate
//
//  Created by Fredson Silva on 29/07/24.
//

import UIKit
import SnapKit
import SwiftUI
import Kingfisher

final class FavoritesTableViewCell: UITableViewCell {
    
    var movies: PopularMovies?
    
    private let moviesPosterImage = UIImageView()
    private let separatorView = UIView()
    static let identifier = "FavoritesTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var genrelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = Utils.SavedColors.titleAdaptiveColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: PopularMovies) {
        
        if let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
            moviesPosterImage.kf.setImage(with: posterURL)
        }
        
        //moviesPosterImage.image = UIImage(named: movie.posterPath)
        titleLabel.text = movie.originalTitle
        //genrelabel.text = movie.
        releaseDateLabel.text = movie.releaseDate
    }
    
    private func setupViews() {
        separatorView.backgroundColor = .secondaryLabel
        moviesPosterImage.layer.cornerRadius = 4
        moviesPosterImage.layer.masksToBounds = true
        
        contentView.addSubview(moviesPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genrelabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(separatorView)
        
        moviesPosterImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Utils.Padding.smaller)
            $0.leading.equalToSuperview().inset(Utils.Padding.big)
            $0.bottom.equalToSuperview().inset(Utils.Padding.smaller)
            $0.height.equalTo(120)
            $0.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Utils.Padding.smaller)
            $0.leading.equalTo(moviesPosterImage.snp.trailing).offset(Utils.Padding.big)
            $0.trailing.equalToSuperview().inset(Utils.Padding.medium)
        }
        
        genrelabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Utils.Padding.smaller)
            $0.leading.equalTo(moviesPosterImage.snp.trailing).offset(Utils.Padding.big)
            $0.trailing.equalToSuperview().inset(Utils.Padding.medium)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(genrelabel.snp.bottom).offset(Utils.Padding.smaller)
            $0.leading.equalTo(moviesPosterImage.snp.trailing).offset(Utils.Padding.big)
            $0.trailing.equalToSuperview().inset(Utils.Padding.medium)
            $0.bottom.equalToSuperview().inset(Utils.Padding.smaller)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.7)
        }
    }
}



// MARK: - SwiftUI Preview

struct FavoritesTableViewCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let cell = FavoritesTableViewCell()
        
        return cell
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct FavoritesCellContentView: View {
    var body: some View {
        VStack {
            FavoritesTableViewCellRepresentable()
                .frame(width: .infinity, height: 140)
                .border(Color.red)
        }
    }
}

#Preview {
    FavoritesCellContentView()
}
