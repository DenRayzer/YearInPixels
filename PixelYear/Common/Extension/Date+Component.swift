//
//  Date+Component.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }

}

