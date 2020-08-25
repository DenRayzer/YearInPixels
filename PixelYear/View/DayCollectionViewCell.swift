//
//  DayCollectionViewCell.swift
//  PixelYear
//
//  Created by Елизавета on 12.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        layer.cornerRadius = 2
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.15).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
