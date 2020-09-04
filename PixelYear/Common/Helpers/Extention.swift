//
//  Extention.swift
//  PixelYear
//
//  Created by Елизавета on 07.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

public enum MultipartFormDataEncodingError: Error {
    case characterSetName
    case name(String)
    case value(String, name: String)
}

// MARK: - URLRequest extention

extension URLRequest {

    public mutating func setMultipartFormData(_ parameters: [String: String], encoding: String.Encoding) throws {

        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())

        let contentType: String = "multipart/form-data; boundary=\(boundary)"

        addValue(contentType, forHTTPHeaderField: "Content-Type")

        httpBody = try {
            var body = Data()

            for (rawName, rawValue) in parameters {
                if !body.isEmpty {
                    body.append("\r\n".data(using: .utf8)!)
                }
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                guard
                rawName.canBeConverted(to: encoding),
                    let disposition = "Content-Disposition: form-data; name=\"\(rawName)\"\r\n".data(using: encoding) else {
                        throw MultipartFormDataEncodingError.name(rawName)
                }
                body.append(disposition)
                body.append("\r\n".data(using: .utf8)!)
                guard let value = rawValue.data(using: encoding) else {
                    throw MultipartFormDataEncodingError.value(rawValue, name: rawName)
                }
                body.append(value)
            }
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            return body
        }()
    }

}

// MARK: - URLRequest extention
extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }

}

// MARK: - StringProtocol extention
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
