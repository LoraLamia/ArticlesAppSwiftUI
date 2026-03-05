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
    @Environment(FeatureManager.self) private var featureManager

    @State var viewModel: RootViewModel

    var body: some View {
        Group {
            if viewModel.isChecking || !featureManager.isReady {
                //here im using isReady variable beacuse i dont want app to glitch (tab view showing before flag for favorites is fetched)
                ProgressView()
            } else if session.currentUser != nil {
                MainView()
            } else {
                WelcomeScreenView()
            }
        }
    }
}

