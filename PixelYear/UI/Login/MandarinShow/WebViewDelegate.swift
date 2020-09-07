//
//  WebViewDelegate.swift
//  PixelYear
//
//  Created by Елизавета on 31.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation


protocol WebViewDelegate: NSObjectProtocol {
    func openWebSite(with request: URLRequest)
    func presentMain()
}
