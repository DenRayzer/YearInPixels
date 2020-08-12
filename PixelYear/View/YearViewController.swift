//
//  YearControllerViewController.swift
//  PixelYear
//
//  Created by Елизавета on 09.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class YearViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = "YearCollectionViewCell"
    var collectionViewFlowLayout: UICollectionViewFlowLayout! = nil
    var years = [1,2,3,4,5,6]

    override func viewDidLoad() {
        super.viewDidLoad()
        MandarinShowService().getYears(year: 2018)
        setupCollectionView()
        setUpCollectionViewItemSize()
    }

    func setupCollectionView() {
        let nib = UINib(nibName: "YearCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }

    func setUpCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let width = collectionView.frame.width
            let heigt = collectionView.frame.height
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: heigt)
            collectionViewFlowLayout.sectionInset = .zero
            collectionViewFlowLayout.scrollDirection = .horizontal
            collectionViewFlowLayout.minimumLineSpacing = 0
            collectionViewFlowLayout.minimumInteritemSpacing = 0
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)

        }
    }

}

extension YearViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! YearCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItem at \(indexPath)")
    }

}

