//
//  RootView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct RootView: View {
    @Environment(SessionManager.self) private var session
    
    var body: some View {
        Group {
            if session.isLoggedIn {
                MainView()
            } else {
                WelcomeScreenView()
            }
        }
    }
}

