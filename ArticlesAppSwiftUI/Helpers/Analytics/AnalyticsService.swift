//
//  AnalyticsService.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

import Foundation
import FirebaseAnalytics

@Observable
final class AnalyticsService {
    func log(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.eventName, parameters: event.parameters)
    }
}
