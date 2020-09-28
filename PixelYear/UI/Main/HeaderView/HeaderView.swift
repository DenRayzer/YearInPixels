//
//  HeaderView.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func didTapNext()
    func didTapPrevious()
}

struct HeaderViewAppearance {
    let previousButtonImage: UIImage
    let nextButtonImage: UIImage
    let monthTextColor: UIColor

    public init(previousButtonImage: UIImage = UIImage(),
        nextButtonImage: UIImage = UIImage(),
        monthTextColor: UIColor = UIColor.black) {
        self.previousButtonImage = previousButtonImage
        self.nextButtonImage = nextButtonImage
        self.monthTextColor = monthTextColor
    }
}

class HeaderView: UIView {
    public weak var delegate: HeaderViewDelegate?
    @IBOutlet var yearButton: UIButton!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @IBAction func previousButtonAction(_ sender: Any) {
        delegate?.didTapPrevious()
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        delegate?.didTapNext()
    }

    func updateYearButton(year: Int) {
        yearButton.setTitle(String(year), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        backgroundColor = .white
    }

}

