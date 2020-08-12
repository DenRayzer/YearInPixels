//
//  Model.swift
//  PixelYear
//
//  Created by Елизавета on 07.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

struct AutorizeAnswer: Codable {
    let message: String
    let token: String
}

struct YearModel: Codable {
    var id: String
    var uid: String
    var year: String
    var jan: String
    var feb: String
    var mar: String
    var apr: String
    var may: String
    var jun: String
    var jul: String
    var aug: String
    var sep: String
    var oct: String
    var nov: String
    var dec: String


}
