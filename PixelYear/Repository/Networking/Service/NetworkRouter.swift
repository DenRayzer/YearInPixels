//
//  NetworkRouter.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype Endpoint: EndpointType
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
}
