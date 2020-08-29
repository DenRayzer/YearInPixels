//
//  NetworkRouter.swift
//  PixelYear
//
//  Created by Елизавета on 21.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}
