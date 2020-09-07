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

    func loadYear(yearNum: Int) {
        service.getYear(year: yearNum) { result in
            switch result {
            case .success(let year):
                DispatchQueue.main.async {
                    self.viewDelegate?.updateYears(with: year)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func loadYears(from year: Int, count: Int) {
        for i in 0...count - 1 {
            loadYear(yearNum: year - i)
        }
    }

    func setDay() {
        service.setDay()
    }

}
