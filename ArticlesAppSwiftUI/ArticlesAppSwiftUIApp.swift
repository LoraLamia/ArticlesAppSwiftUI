//
//  ArticlesAppSwiftUIApp.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

@main
struct ArticlesAppSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let session = SessionManager()
    private let trackingPermissionManager = TrackingPermissionManager()
    private var container: DependencyContainer
    
    init() {
        self.container = DependencyContainer(sessionManager: session)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel(userUseCase: container.articleUseCase, session: session))
                .environment(session)
                .environment(container)
                .environment(trackingPermissionManager)
        }
    }
}
