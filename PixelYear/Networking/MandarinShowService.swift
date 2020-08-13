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

class MandarinShowService: Service {



    func getYear(year: Int) -> YearModel? {
        let semaphore = DispatchSemaphore(value: 0)
        guard let url = NetworkHelper.prepareUrl(with: MandarinShowServiceKeys.host,
            for: "\(year)/") else { return nil }
        guard let request = getYearsRequest(url: url) else { return nil }
        let session = URLSession.shared
        var answer: [YearModel]?
        let task = session.dataTask(with: request) {
            data, response, error in
            do {
                if (try? JSONSerialization.jsonObject(with: data!, options: [])) != nil { /*  print(json) */ }
                answer = try JSONDecoder().decode([YearModel].self, from: data!)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            semaphore.signal()
        }

        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)

        return answer?[0]
    }

    func getYearsRequest(url: URL) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = SensitiveDataService().getToken() else { return nil }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }

    func setDay() { }

}
