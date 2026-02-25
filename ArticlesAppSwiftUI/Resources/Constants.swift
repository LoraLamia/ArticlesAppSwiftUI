//
//  Constants.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

enum Constants {
    enum API {
        static let baseURL = "https://interview-assignment-be-rn3c.onrender.com"
        static let articlesEndpoint = "/api/articles"
        static let topicsEndpoint = "/api/articles/topics"
        
        static let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5OWVkNTU3YmEyN2NmOTM5ODVhOGRjZSIsInVzZXJuYW1lIjoibWFya29ob3J2YXQiLCJyb2xlIjoiQmFzaWMiLCJpYXQiOjE3NzIwMTY5ODQsImV4cCI6MTc3MjAyNzc4NH0.cgqVq84GYXBE4JGr_YPQ5vImswMSY-C-OOT2-UPfPiE"
    }
    
    enum Keys {
        static let favoritesKey = "favorite_articles"
    }
    
    enum Strings {
        static let favorites = "Favorites"
        static let articles = "Articles"
        static let searchBarPlaceholder = "Search articles"
        static let allArticles = "all articles"
    }
    
    enum Fonts {
        static let extraSmall: CGFloat = 12
        static let small: CGFloat = 14
        static let normal: CGFloat = 16
        static let large: CGFloat = 18
    }
    
    enum Colors {
        static let authorAndDateTextColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.6)
        static let summaryTextColor = Color(red: 85/255, green: 85/255, blue: 85/255)
        static let cellBackgroundColor = Color(red: 230/255, green: 229/255, blue: 227/255)
        static let topicAndTagsTextColor = Color.blue
        static let favoriteIconColor = Color.blue
        static let searchBarBorderColor = Color.blue
        static let xMarkIconColor = Color.gray
        static let topicCellSelectedColor = Color.blue
        static let topicCellUnselectedColor = Color.gray.opacity(0.2)
        static let topicCellTextUnselectedColor = Color.blue
        static let topicCellTextSelectedColor = Color.white
    }
    
    enum Spacing {
        static let extraSmall: CGFloat = 6
        static let small: CGFloat = 10
        static let normal: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    enum Icons {
        static let favoriteIconName: String = "star.fill"
        static let unfavoriteIconName: String = "star"
        static let listName: String = "text.document"
        static let xMarkName: String = "xmark.circle.fill"
        static let arrowUpName: String = "arrow.up"
        static let arrowDownName: String = "arrow.down"
    }
    
    enum Padding {
        static let extraSmall: CGFloat = 10
        static let small: CGFloat = 12
        static let normal: CGFloat = 16
        static let large: CGFloat = 20
    }
    
    enum CornerRadius {
        static let extraSmall: CGFloat = 8
        static let small: CGFloat = 10
        static let normal: CGFloat = 12
        static let large: CGFloat = 26
    }
    
    enum Height {
        static let extraSmall: CGFloat = 15
        static let small: CGFloat = 20
        static let normal: CGFloat = 25
        static let large: CGFloat = 40
    }
}

