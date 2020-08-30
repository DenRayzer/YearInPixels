//
//  StringProtocol.swift
//  PixelYear
//
//  Created by Елизавета on 30.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

}
