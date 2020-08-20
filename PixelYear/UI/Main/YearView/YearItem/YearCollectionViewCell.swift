//
//  YearCollectionViewCell.swift
//  PixelYear
//
//  Created by Елизавета on 12.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var year: Year!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setUpCollectionViewItemSize()
    }

    func setUpCollectionViewItemSize() {
        let interItemSpacing: CGFloat = 2
        let rowSpacing: CGFloat = 1
        let width = (collectionView.frame.width - (12 * interItemSpacing)) / 13
        print("width   \(width)")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width)
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = rowSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = collectionView.frame.width * 0.1 / 11
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    func setYear(year: Year) {
        self.year = year
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
    }

}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension YearCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        365
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)

        if (indexPath.row == 1) || (indexPath.row == 2) {
            cell.backgroundColor = .black
        }
        return cell
    }

}


