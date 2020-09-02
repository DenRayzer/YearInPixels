//
//  YearPresenter.swift
//  PixelYear
//
//  Created by Елизавета on 13.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

protocol YearViewProtocol: class {

}

protocol YearPresenterProtocol: class {

}

class YearPresenter: YearPresenterProtocol {
    private var mandarinShowService: CalendarService
    private let view: YearViewProtocol

    init(view: YearViewProtocol, service: CalendarService = MandarinShowService()) {
        self.mandarinShowService = service
        self.view = view
    }

}
