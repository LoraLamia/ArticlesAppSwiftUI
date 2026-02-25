//
//  ArticlesAppSwiftUIApp.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

@main
struct ArticlesAppSwiftUIApp: App {
    private let session = SessionManager()
    private var container: DependencyContainer
    
    init() {
        container = DependencyContainer(sessionManager: session)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .environment(session)
        }
    }
}
