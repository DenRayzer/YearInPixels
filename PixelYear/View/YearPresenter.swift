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
    private var mandarinShowService: Service
    private let view: YearViewProtocol

    init(view: YearViewProtocol, service: Service = MandarinShowService()) {
        self.mandarinShowService = service
        self.view = view
    }

}
