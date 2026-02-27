//
//  KeychainManager.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import Foundation
import Security

final class KeychainManager {

    static func saveToken(token: String) {
        let data = Data(token.utf8)

        deleteToken()

        SecItemAdd([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constants.Keychain.tokenKey,
            kSecValueData: data
        ] as CFDictionary, nil)
    }

    static func getToken() -> String? {
        var result: AnyObject?

        SecItemCopyMatching([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constants.Keychain.tokenKey,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary, &result)

        guard let data = result as? Data else { return nil }
        return String(decoding: data, as: UTF8.self)
    }

    static func deleteToken() {
        SecItemDelete([
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: Constants.Keychain.tokenKey
        ] as CFDictionary)
    }
}

