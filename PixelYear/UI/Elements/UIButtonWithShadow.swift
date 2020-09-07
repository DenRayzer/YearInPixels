//
//  UIButtonWithShadow.swift
//  PixelYear
//
//  Created by Елизавета on 28.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class UIButtonWithShadow: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func configure() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.init(named: "Gradient_left")!, UIColor.init(named: "Gradient_right")!].map {
            $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.2, y: 1)
        gradientLayer.cornerRadius = 10
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.red.withAlphaComponent(0.35).cgColor
        self.layer.shadowRadius = 20
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
    }

}
