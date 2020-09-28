//
//  YearViewDelegate.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation


protocol YearPresenterDelegate: NSObjectProtocol {
    func updateYears(with year: Year)
}
