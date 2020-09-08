//
//  HTTPTask.swift
//  PixelYear
//
//  Created by Елизавета on 08.09.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public typealias Parameters = [String: String]

public enum HTTPTask {
    case requestWithMultipartFormData(parameters: Parameters?)
    case requestParameters(urlParameters: [(String,String)]?)
}
