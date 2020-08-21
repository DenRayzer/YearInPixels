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
    case request
    case requestWithMultipartFormData(parameters: Parameters?)
    case requestParametersHeaders(urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
}
