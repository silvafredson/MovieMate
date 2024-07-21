//
//  NoFavoriteCollectionViewCell.swift
//  MovieMate
//
//  Created by Fredson Silva on 21/07/24.
//

import UIKit
import SnapKit
import SwiftUI

class NoFavoriteCollectionViewCell: UICollectionViewCell {
    private lazy var emoji: UILabel = {
        let image = UILabel()
        image.text = "😅"
        image.font = .systemFont(ofSize: 120)
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "You do not have any favorites yet!"
        label.font = .systemFont(ofSize: Size.big, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        contentView.addSubview(emoji)
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        emoji.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(emoji.snp.bottom).offset(Padding.large)
            $0.trailing.leading.equalToSuperview()
        }
    }
    
}

 // MARK: - SwiftUI Preview

struct MyUIViewControllerRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let cell = NoFavoriteCollectionViewCell()
        
        return cell
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct ContentView: View {
    var body: some View {
        VStack {
            MyUIViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
            //.frame(height: 160)
            //.border(Color.black)
       }
    }
}

#Preview {
    ContentView()
}
