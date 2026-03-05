//
//  FeatureManager.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

import Foundation
import FirebaseRemoteConfig

@Observable
final class FeatureManager: FeatureManagerContract {
    private(set) var isFavoritesEnabled = false
    private(set) var isReady = false
    
    private let remoteConfig: RemoteConfig
    
    init(remoteConfig: RemoteConfig = .remoteConfig()) {
        self.remoteConfig = remoteConfig
        configure()
        fetchAndActivate()
        listenForRealtimeUpdates()
    }
    
    private func configure() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults([
            Constants.RemoteConfig.favoritesEnabled: true as NSObject
        ])
    }
    
    private func fetchAndActivate() {
        remoteConfig.fetchAndActivate { [weak self] _, _ in
            guard let self else { return }
            self.updateValues()
            self.isReady = true
        }
    }
    
    private func listenForRealtimeUpdates() {
        remoteConfig.addOnConfigUpdateListener { [weak self] _, _ in
            guard let self else { return }
            
            self.remoteConfig.activate { _, _ in
                Task { @MainActor in
                    self.updateValues()
                }
            }
        }
    }
    
    private func updateValues() {
        isFavoritesEnabled = remoteConfig[Constants.RemoteConfig.favoritesEnabled].boolValue
    }
}

