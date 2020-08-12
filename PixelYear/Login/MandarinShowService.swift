//
//  MandarinShowServicw.swift
//  PixelYear
//
//  Created by Елизавета on 10.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation

fileprivate enum MandarinShowServiceKeys {
    static let host = "https://mandarinshow.ru/api/app-pixels/year/"
}

/*
 let task = session.dataTask(with: request, completionHandler: { (data: Data?,
 response: URLResponse?,
 error: Error?) -> Void in
 do {
 let answer = try JSONDecoder().decode(AutorizeAnswer.self, from: data!)
 token = answer.token

 } catch {
 print("JSON error: \(error.localizedDescription)")
 }
 semaphore.signal()
 })

 task.resume()
 **/

class MandarinShowService {
    func getYears(year: Int) -> [YearModel]? {

        guard let url = NetworkHelper.prepareUrl(with: MandarinShowServiceKeys.host,
                                                 for: "\(year)/") else { return nil }
        guard let request = getYearsRequest(url: url) else { return nil }
        let session = URLSession.shared
        var answer: [YearModel]?
        let task = session.dataTask(with: request) {
            data, response, error in
            do {
           //     print(response as Any)
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
  print(json)
                }

                answer = try JSONDecoder().decode([YearModel].self, from: data!)


 print("AYE     \(answer![0].year)")
            } catch {
                 print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
        return answer

    }
    func getYearsRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = SensitiveDataService().getToken() else { return nil }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
