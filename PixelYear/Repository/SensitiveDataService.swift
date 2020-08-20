//
//  SensetiveDataProcessor.swift
//  PixelYear
//
//  Created by Елизавета on 06.08.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import Foundation
import KeychainAccess

enum KeychainKeys {
    static let userAccountMandarinShowKey = "MandarinCurrentAccount"
    static let mandarinShowAccessTokenKey = "MaindarinAccessToken"
}

class SensitiveDataService {

    private let myKeychain = Keychain(service: "MandarinShow")
    func saveMandarinshowAccessToken(token: String) {
        do {
            try myKeychain.set(token, key: KeychainKeys.mandarinShowAccessTokenKey)
        }
        catch let error {
            print(error)
        }
    }

    func getMandarinShowToken() -> String? {
        let token = try? myKeychain.getString(KeychainKeys.mandarinShowAccessTokenKey)
        return token
    }

}
