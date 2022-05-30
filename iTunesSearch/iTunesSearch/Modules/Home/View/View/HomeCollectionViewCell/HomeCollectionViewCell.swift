//
//  HomeCollectionViewCell.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: Views
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private lazy var collectionNamelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    private lazy var collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: HomeCollectionViewCellViewModel) {
        if let imageUrl = viewModel.artworkUrl {
            thumbnailImageView.downloaded(from: imageUrl)
        }
        
        collectionNamelabel.text = viewModel.collectionName
        collectionPriceLabel.text = viewModel.collectionPrice
        releaseDateLabel.text = viewModel.releaseDate
    }
}

// MARK: - Helpers
private extension HomeCollectionViewCell {
    private func setupViews() {
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(collectionNamelabel)
        contentView.addSubview(collectionPriceLabel)
        contentView.addSubview(releaseDateLabel)
        
        setupLayout()
    }

    private func setupLayout() {
        thumbnailImageView.setConstarint(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            topConstraint: 16,
            centerX: contentView.centerXAnchor,
            width: 100,
            height: 120
        )
        
        collectionNamelabel.setConstarint(
            top: thumbnailImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            topConstraint: 8,
            leadingConstraint: 16,
            trailingConstraint: 16
        )
        
        collectionPriceLabel.setConstarint(
            top: collectionNamelabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            topConstraint: 16,
            leadingConstraint: 16
        )

        releaseDateLabel.setConstarint(
            top: collectionPriceLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            topConstraint: 4,
            leadingConstraint: 16
        )
    }
}
