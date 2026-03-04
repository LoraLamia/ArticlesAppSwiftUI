//
//  ArticlesEvent.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

enum ArticlesEvent: AnalyticsEvent {
    case favoriteToggled(isNowFavorite: Bool)
    case sortChanged(isAscending: Bool)
    
    var eventName: String {
        switch self {
        case .sortChanged:
            return "sort_changed"
        case .favoriteToggled:
            return "favorite_toggled"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .favoriteToggled(let isNowFavorite):
            return ["is_now_favorite": isNowFavorite]
            
        case .sortChanged(let isAscending):
            return ["is_ascending": isAscending]
        }
    }
}
