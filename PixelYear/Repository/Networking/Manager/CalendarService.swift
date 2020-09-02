//
//  Service.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

protocol CalendarService {
    func getYear(year: Int, completion: @escaping (Result<Year, Error>) -> Void)
    func setDay(day: Day, completion: @escaping (Result<Void, Error>) -> Void)
}
