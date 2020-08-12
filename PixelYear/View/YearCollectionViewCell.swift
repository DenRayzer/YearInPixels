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

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        setUpCollectionViewItemSize()
    }

    func setUpCollectionViewItemSize() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
    }

}
extension YearCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        365
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        return cell
    }

}


