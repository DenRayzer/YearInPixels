//
//  Service.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

protocol Service {
   func getYear(year: Int) -> YearModel?
   func setDay()
}
