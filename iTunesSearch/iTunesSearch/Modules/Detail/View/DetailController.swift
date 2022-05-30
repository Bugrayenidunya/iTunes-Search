//
//  DetailController.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

// MARK: - DetailViewDelegate
protocol DetailViewDelegate: AnyObject {
    func setupViews()
}

// MARK: - DetailController
class DetailController: UIViewController {
    
    // MARK: Propeties
    private let presenter: DetailPresenterInput
    
    // MARK: Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let collectionNamelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    private let longDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }
    
    init(presenter: DetailPresenterInput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: DetailViewModel) {
        collectionNamelabel.text = viewModel.name
        collectionPriceLabel.text = viewModel.price
        releaseDateLabel.text = viewModel.releaseDate
        longDescriptionLabel.text = viewModel.description
        
        if let imageUrl = viewModel.imageUrl {
            thumbnailImageView.downloaded(from: imageUrl)
        }
    }
}

// MARK: - DetailViewDelegate
extension DetailController: DetailViewDelegate {
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = "Detail"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(collectionNamelabel)
        contentView.addSubview(collectionPriceLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(longDescriptionLabel)
        
        scrollView.setConstarint(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            leadingConstraint: .zero,
            bottomConstraint: .zero,
            trailingConstraint: .zero,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        
        contentView.setConstarint(
            top: scrollView.topAnchor,
            bottom: scrollView.bottomAnchor,
            topConstraint: .zero,
            bottomConstraint: .zero,
            centerX: scrollView.centerXAnchor,
            width: UIScreen.main.bounds.width
        )

        thumbnailImageView.setConstarint(
            top: contentView.topAnchor,
            topConstraint: 16,
            centerX: contentView.centerXAnchor,
            width: 200,
            height: 240
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
            topConstraint: 4,
            leadingConstraint: 16
        )

        longDescriptionLabel.setConstarint(
            top: releaseDateLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            topConstraint: 8,
            leadingConstraint: 16,
            bottomConstraint: 32,
            trailingConstraint: 16
        )
    }
}
