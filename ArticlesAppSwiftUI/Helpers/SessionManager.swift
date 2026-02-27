//
//  SessionManager.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct User {
    let username: String
}

struct UserData {
    let username: String
    let accessToken: String
}

@Observable
final class SessionManager {
    private(set) var currentUser: User?
    
    func login(with userData: UserData) {
        currentUser = User(username: userData.username)
        KeychainManager.saveToken(token: userData.accessToken)
    }

    func logout() {
        currentUser = nil
        KeychainManager.deleteToken()
    }
}

