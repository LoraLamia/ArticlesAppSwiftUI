//
//  SessionManager.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

@Observable
final class SessionManager {
    
    var isLoggedIn: Bool = false
    
    init() {
        checkLoginStatus()
    }
    
    func checkLoginStatus() {
        isLoggedIn = KeychainManager.getToken() != nil
    }
    
    func logout() {
        KeychainManager.deleteToken()
        isLoggedIn = false
    }
}

