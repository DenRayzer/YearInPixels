//
//  HTTPTask.swift
//  PixelYear
//
//  Created by Елизавета on 21.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation
public typealias Parameters = [String:String]

public enum HTTPTask {
    case requestParameters(urlParameters: Parameters?)
    case requestWithMultipartFormData(parameters: Parameters?)
    case requestHeaders(additionHeaders: HTTPHeaders?)
}
