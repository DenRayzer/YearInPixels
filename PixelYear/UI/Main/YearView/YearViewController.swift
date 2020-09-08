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
        presenter.loadYears(from: currentYear, count: 5)
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
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.scrollDirection = .horizontal
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
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in collectionView.visibleCells {
            let indexPath = collectionView.indexPath(for: cell)
            if currentYear - years[indexPath!.row].year > 0 {
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
       if x >= collectionView.contentSize.width { return }
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        currentYear += 1
        header.updateYearButton(year: currentYear)

    }

    func didTapPrevious() {
        let x = collectionView.contentOffset.x - collectionView.frame.width
        if x >= 0 {
            collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
            currentYear -= 1
            header.updateYearButton(year: currentYear)
        }
    }
}

// MARK: - YearPresenterDelegate
extension YearViewController: YearPresenterDelegate {
    func updateYears(with year: Year) {
        years.append(year)
        years.sort(by: { $0.year > $1.year })
        collectionView.reloadData()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension YearViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
