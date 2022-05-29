//
//  HomeController.swift
//  iTunesSearch
//
//  Created by Enes Buğra Yenidünya on 28.05.2022.
//

import UIKit

// MARK: HomeViewDelegate
protocol HomeViewDelegate: AnyObject {
    func setupViews()
    func update(with viewModel: HomeViewModel)
}

final class HomeController: UIViewController {
    
    // MARK: Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, HomeCollectionViewCellViewModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, HomeCollectionViewCellViewModel>
    
    // MARK: Properties
    private var sections: [Section] = []
    private var snapshot = NSDiffableDataSourceSnapshot<Section, HomeCollectionViewCellViewModel>()
    private lazy var dataSource = generateDatasource()
    
    private let presenter: HomePresenterInput
    
    private enum Constant {
        static let headerKind = "header"
        static let sectionInset = 2.0
        static let half = 0.5
        static let full = 1.0
        static let headerHeight = 44.0
    }
    
    // MARK: Views
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentItems = ["All", "Movies", "Musics", "Apps", "Books"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.selectedSegmentIndex = 0
        //control.addTarget(self, action: #selector(segmentedControl(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = .themeColor
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)
        ], for: .selected)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ], for: .normal)
        return segmentedControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let compositionalLayout = generateCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.identifier
        )
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        applySnapshot(animatingDifferences: false)
        setupSupplementryView()
    }
    
    init(presenter: HomePresenterInput) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
private extension HomeController {
    /// Applies new data to dataSource
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    /// Generates `UICollectionViewDiffableDataSource`
    func generateDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cellViewModel) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
                    return .init(frame: .zero)
                }
                
                cell.configure(with: cellViewModel)
                
                return cell
            })
        
        return dataSource
    }
    /// Setups `Section`
    func setupSupplementryView() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.identifier, for: indexPath) as? SectionHeaderReusableView
            
            view?.titleLabel.text = section.title
            
            return view
        }
    }
    /// Generates `UICollectionViewCompositionalLayout` with given items, group, header and section
    func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let item = generateLayoutItems()
        
        // Group
        let groupDimension = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .fractionalHeight(Constant.half)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupDimension, subitems: [item])
        
        return .init(section: generateSection(for: group))
    }
    /// Generates `NSCollectionLayoutItem` with given dimensions
    func generateLayoutItems() -> NSCollectionLayoutItem {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.half),
            heightDimension: .fractionalHeight(Constant.full)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: Constant.sectionInset, leading: Constant.sectionInset, bottom: Constant.sectionInset, trailing: Constant.sectionInset)
        
        return item
    }
    /// Generates `NSCollectionLayoutBoundarySupplementaryItem` with given dimensions
    func generateHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemDimension = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(Constant.full),
            heightDimension: .estimated(Constant.headerHeight)
        )
        return .init(layoutSize: headerItemDimension, elementKind: UICollectionView.elementKindSectionHeader,  alignment: .top)
    }
    /// Generates `NSCollectionLayoutSection` with given group
    func generateSection(for group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constant.sectionInset,
            leading: Constant.sectionInset,
            bottom: Constant.sectionInset,
            trailing: Constant.sectionInset
        )
        
        section.boundarySupplementaryItems = [generateHeader()]
        
        return section
    }
}

// MARK: - HomeViewDelegate
extension HomeController: HomeViewDelegate {
    func update(with viewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.sections = [Section(title: "Result", items: viewModel.medias)]
            self.applySnapshot(animatingDifferences: true)
        }
    }
    
    func setupViews() {
        navigationItem.title = "iTunes Search"
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
        searchBar.setConstarint(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            topConstraint: 24,
            leadingConstraint: 16,
            trailingConstraint: 16,
            height: 44
        )
        
        segmentedControl.setConstarint(
            top: searchBar.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            topConstraint: 10,
            leadingConstraint: 24,
            trailingConstraint: 24,
            height: 32
        )
        
        collectionView.setConstarint(
            top: segmentedControl.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            topConstraint: 16,
            leadingConstraint: .zero,
            bottomConstraint: .zero,
            trailingConstraint: .zero
        )
    }
}

// MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegate {
    
}
