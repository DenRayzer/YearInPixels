//
//  Extention.swift
//  PixelYear
//
//  Created by Елизавета on 07.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation


extension URLRequest {
    public mutating func setMultipartFormData(_ parameters: [String: String], encoding: String.Encoding = String.defaultCStringEncoding) throws {

        let boundary = generateBoundary()

        setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody = {
            var body = Data()
            for(key, value) in parameters {

                body.append(convertFormField(named: key, value: value, using: boundary))
            }
            body.append("--\(boundary)--\r\n")
            return body
        }()
    }

    func convertFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }

    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

}
