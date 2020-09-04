//
//  YearCollectionViewCell2.swift
//  PixelYear
//
//  Created by Елизавета on 01.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    let scrollView = UIScrollView()
    var year: Year?

    override init(frame: CGRect) {
        super.init(frame: .zero)

        configureScrollView()
        createDays()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createDays() {
        for _ in 0...30 {
            for _ in 0...11 {
                let day = UIView()
                //  day.backgroundColor = .white
                day.layer.backgroundColor = UIColor.lightGray.cgColor
                day.layer.cornerRadius = 2
                day.layer.borderWidth = 1
                day.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
                scrollView.addSubview(day)
            }
        }
    }

    func configureScrollView() {
        contentView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        scrollView.showsVerticalScrollIndicator = false
    }

    func setSize() {
        guard let year = year else { return }
        let margin = 3
        let widt = (Int(self.frame.width) - margin) / 12
        var count = 0
        for i in 0...year.months.count - 1 {

            let cow = year.months[i].count - 1
            for j in 0...cow {
                let day = scrollView.subviews[count]
                day.frame = CGRect(x: i * widt + margin, y: j * widt + margin,
                    width: widt - margin, height: widt - margin)
                let yearDay = year.months[i][j]
                day.layer.backgroundColor = UIColor(named: yearDay.status)?.cgColor
                count += 1
            }
        }
        scrollView.contentSize = CGSize(width: self.frame.width, height: CGFloat(widt) * 31 + CGFloat(margin))
    }

    func setYear(year: Year) {
        self.year = year
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
    }


}
