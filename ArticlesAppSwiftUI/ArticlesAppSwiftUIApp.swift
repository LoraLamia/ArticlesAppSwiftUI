//
//  ArticlesAppSwiftUIApp.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI
import FirebaseCore

@main
struct ArticlesAppSwiftUIApp: App {
    private let session = SessionManager()
    private let trackingPermissionManager = TrackingPermissionManager()
    private let analyticsService = AnalyticsService()
    private let featureManager: FeatureManager
    private var container: DependencyContainer
    
    init() {
        FirebaseApp.configure()
        self.container = DependencyContainer(sessionManager: session)
        self.featureManager = FeatureManager()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: RootViewModel(userUseCase: container.articleUseCase, session: session))
                .environment(session)
                .environment(container)
                .environment(trackingPermissionManager)
                .environment(analyticsService)
                .environment(featureManager)
        }
    }
}
