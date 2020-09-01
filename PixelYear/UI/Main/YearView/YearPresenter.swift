//
//  YearPresenter.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation


class YearViewPresenter {
    private var service: Service
    weak private var viewDelegate: YearViewDelegate?

    init(service: Service = MandarinShowService()) {
        self.service = service
    }

    func setViewDelegate(viewDelegate: YearViewDelegate?) {
        self.viewDelegate = viewDelegate
    }

    func loadYears(from year: Int) {

    }

}
