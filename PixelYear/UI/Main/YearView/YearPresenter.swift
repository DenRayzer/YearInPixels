//
//  YearPresenter.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

class YearViewPresenter {
    private var service: CalendarService
    weak private var viewDelegate: YearPresenterDelegate?

    init(service: CalendarService = MandarinShowService()) {
        self.service = service
    }

    func setViewDelegate(viewDelegate: YearPresenterDelegate?) {
        self.viewDelegate = viewDelegate
    }

    func loadYear(yearNum: Int) {
        service.getYear(yearDate: yearNum) { result in
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

    func setDay(day: Day) {
        service.setDay(day: day) { _ in
        }
    }

}
