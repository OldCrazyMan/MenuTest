//
//  SceneDelegate.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import UIKit

protocol ScrollToCategoryViewDelegate: AnyObject {
    func scrollToRow(with index: IndexPath)
}

final class CategoriesView: UITableViewHeaderFooterView {
    
    weak var delegate: ScrollToCategoryViewDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createCompositionalLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.backgroundColor = #colorLiteral(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var categories = ["Пицца", "Комбо", "Десерты", "Напитки", "Соусы"]
    
    init() {
        super.init(reuseIdentifier: "String")
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(section: createButtonsView())
    }
    
    private func createButtonsView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        
        let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1.3)
        let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.26),
                                             heightDimension: rowHeight)
        let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: row)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 25, trailing: 0)
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

// MARK: - UITableView

extension CategoriesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = categories[indexPath.row]
        return cell
    }
}

extension CategoriesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else { return }
        cell.isSelected = true
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.scrollToRow(with: indexPath)
    }
}
