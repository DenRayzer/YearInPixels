//
//  HeaderView.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
    func didTapNextMonth()
    func didTapPreviousMonth()
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
    public var appearance = HeaderViewAppearance()
    private let monthLabel = UILabel()
    private let previousButton = UIButton()
    private let nextButton = UIButton()


    public weak var delegate: HeaderViewDelegate?

    override public init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        subviews.forEach { $0.removeFromSuperview() }

        backgroundColor = .white

        monthLabel.textAlignment = .center
        monthLabel.textColor = appearance.monthTextColor

        previousButton.setImage(appearance.previousButtonImage, for: .normal)
        previousButton.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)

        nextButton.setImage(appearance.nextButtonImage, for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)

        addSubview(monthLabel)
        addSubview(previousButton)
        addSubview(nextButton)

        layoutSubviews()

    }

    @objc
    private func didTapNext(_ sender: UIButton) {
        delegate?.didTapNextMonth()
    }

    @objc
    private func didTapPrevious(_ sender: UIButton) {
        delegate?.didTapPreviousMonth()
    }
}

