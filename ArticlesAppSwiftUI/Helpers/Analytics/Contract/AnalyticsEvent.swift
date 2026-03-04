//
//  AnalyticsEvent.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

protocol AnalyticsEvent {
    var eventName: String { get }
    var parameters: [String: Any]? { get }
}
