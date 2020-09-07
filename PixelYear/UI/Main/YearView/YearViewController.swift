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
    private var currentYear = Calendar.current.component(.year, from: Date())
    private var years: [Year] = []
    private var currentYearIndexPath = IndexPath()
    private var presenter = YearViewPresenter()
    private var lastContentOffset: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var header: HeaderView! {
        didSet {
            header.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(viewDelegate: self)
        presenter.loadYears(from: currentYear, count: 10)
        setupCollectionView()
        setUpCollectionViewItemSize()
    }

    func setupCollectionView() {
        collectionView.register(YearCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
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
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: false)
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
        currentYearIndexPath = indexPath
        cell.setYear(year: years[currentYearIndexPath.row])
        cell.setSize()
        print("year \(years[currentYearIndexPath.row].year)")
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            if currentYear - years[indexPath!.row].year > 0 && indexPath?.row != years.count - 1 {
                currentYear -= 1
            }
            if currentYear - years[indexPath!.row].year < 0 {
                currentYear += 1
            }
            header.updateYearButton(year: currentYear)
        }
    }

}

// MARK: - HeaderViewDelegate
extension YearViewController: HeaderViewDelegate {
    func didTapNext() {
        let x = collectionView.contentOffset.x + collectionView.frame.width
        guard x < collectionView.contentSize.width else { return }
        currentYearIndexPath.row += 1
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
            currentYearIndexPath.row -= 1
            years.append(Year(year: previousYear))
            collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
        }
        header.updateYearButton(year: currentYear)
    }
}

// MARK: - YearViewController
extension YearViewController: YearViewDelegate {
    func updateYears(with year: Year) {
        years.append(year)
        years.sort(by: { $0.year > $1.year })
        collectionView.reloadData()
    }

}
