//
//  WebViewPresenter.swift
//  PixelYear
//
//  Created by Елизавета on 31.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation


class WebViewPresenter {
    private var service: MandarinShowLoginService
    weak private var viewDelegate: PresenterDelegate!

    init(service: MandarinShowLoginService = MandarinShowLoginService()) {
        self.service = service
    }

    func setViewDelegate(viewDelegate: PresenterDelegate) {
        self.viewDelegate = viewDelegate
    }

    func displayWebSite() {
        guard let request = service.autorizePageRequest() else { return }
        viewDelegate?.openWebSite(with: request)
    }

    func getAccessToken(with code: String) {
        service.getAccessToken(with: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                let dataService = SensitiveDataService()
                dataService.saveMandarinshowAccessToken(token: token)
                DispatchQueue.main.async {
                    self.viewDelegate?.presentMain()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
