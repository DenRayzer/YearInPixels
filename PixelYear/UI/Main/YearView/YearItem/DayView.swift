//
//  DayView.swift
//  PixelYear
//
//  Created by Елизавета on 09.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit


class DayView: UIView {
    var day: Day!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.layer.cornerRadius = 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    }

    func setDay(day: Day) {
        self.day = day
    }

}
