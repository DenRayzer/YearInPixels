//
//  CustomViewCell.swift
//  PixelYear
//
//  Created by Елизавета on 06.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        return view
    }()

    lazy var dateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 60, y: 10, width: self.frame.width - 80, height: 30))
        return lbl
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        addSubview(backView)
        backView.addSubview(dateLabel)
    }

}

