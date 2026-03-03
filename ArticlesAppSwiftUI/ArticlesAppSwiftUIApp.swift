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
        self.container = DependencyContainer(sessionManager: session)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel(userUseCase: container.articleUseCase, session: session))
                .environment(session)
                .environment(container)
        }
    }
}
