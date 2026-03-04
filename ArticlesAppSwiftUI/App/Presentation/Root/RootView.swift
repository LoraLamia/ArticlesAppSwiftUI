//
//  RootView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI
import Combine

struct RootView: View {
    @Environment(SessionManager.self) private var session
    @Environment(DependencyContainer.self) private var container
    @Environment(TrackingPermissionManager.self) private var trackingManager
    @State var viewModel: RootViewModel

    var body: some View {
        Group {
            if viewModel.isChecking {
                ProgressView()
            } else if session.currentUser != nil {
                MainView()
            } else {
                WelcomeScreenView()
            }
        }
        .task {
            await trackingManager.askToTrackIfNeeded()
        }
    }
}

