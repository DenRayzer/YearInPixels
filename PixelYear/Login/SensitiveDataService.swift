//
//  SensetiveDataProcessor.swift
//  PixelYear
//
//  Created by Елизавета on 06.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation
import Locksmith

enum KeychainKeys {
    static let userAccountKey = "currentAccount"
    static let accessTokenKey = "accessToken"
}

class SensitiveDataService {

   static func saveAccessToken(token: String) {
        do {
            try Locksmith.saveData(data: [KeychainKeys.accessTokenKey: token],
                forUserAccount: KeychainKeys.userAccountKey)
        } catch {
            print("Unable to save data")
        }
    }

    func getToken() -> String? {
        let userDataDictionary = Locksmith.loadDataForUserAccount(userAccount: KeychainKeys.userAccountKey)
        return userDataDictionary?[KeychainKeys.accessTokenKey] as? String
    }

}
