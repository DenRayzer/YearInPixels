//
//  YearControllerViewController.swift
//  PixelYear
//
//  Created by Елизавета on 09.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class YearViewController: UIViewController {
    private let cellIdentifier = "YearCollectionViewCell"
    private var collectionViewFlowLayout: UICollectionViewFlowLayout! = nil
    private var presenter = YearPresenter()
    private var years: [Int: Year] = [:]
    private var currentYear = Calendar.current.component(.year, from: Date())
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var header: HeaderView! {
        didSet {
            header.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //   MandarinShowService().getYears(year: 2018)
        setupCollectionView()
        setUpCollectionViewItemSize()
        if let year = presenter.getYear(year: currentYear) { years[year.year] = year }

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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension YearViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! YearCollectionViewCell
        //    if let currentYearIndex = years.firstIndex(where: { $0.year == currentYear }) {
        //   cell.setYear(year: years[currentYear]!)
        print("\(indexPath.row) indexpath")
        if collectionView.contentOffset.x < CGPoint().x {

        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItem at \(indexPath)")
    }
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        print("tak tak")
    }



}


// MARK: - HeaderViewDelegate
extension YearViewController: HeaderViewDelegate {
    func didTapNext() {
        let x = collectionView.contentOffset.x + collectionView.frame.width
        guard x < collectionView.contentSize.width else { return }

        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        currentYear += 1
        header.updateYearButton(year: currentYear)
    }

    func didTapPrevious() {
        let x = collectionView.contentOffset.x - collectionView.frame.width


        if x >= 0 {
            collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        } else {
            let previousYear = currentYear - 1
            currentYear = previousYear
            years[previousYear] = Year(year: previousYear)
            collectionView.reloadData()
            print("AUA")
            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }
        header.updateYearButton(year: currentYear)
    }
}
