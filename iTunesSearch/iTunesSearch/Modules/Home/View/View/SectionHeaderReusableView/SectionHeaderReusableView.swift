//
//  SectionHeaderReusableView.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 29.05.2022.
//

import UIKit

final class SectionHeaderReusableView: UICollectionReusableView {
    
    // MARK: Properties
    static let identifier = "SectionHeaderReusableView"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension SectionHeaderReusableView {
    func setupView() {
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        
        titleLabel.setConstarint(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstraint: 10,
            leadingConstraint: 10,
            bottomConstraint: 10,
            trailingConstraint: 10
        )
    }
}
