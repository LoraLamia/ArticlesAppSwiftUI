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
        static let articleByIdEndpoint = "/api/articles/"
        static let registerEndpoint = "/api/auth/register"
        static let loginEndpoint = "/api/auth/login"
    }
    
    enum UserDefaults {
        static let favoritesKey = "favorite_articles"
    }
    
    enum Keychain {
        static let tokenKey = "access_token"
    }
    
    enum Strings {
        static let favorites = "Favorites"
        static let articles = "Articles"
        static let searchBarPlaceholder = "Search articles"
        static let allArticles = "all articles"
        static let newUser = "New user?"
        static let existingUser = "Already have an account?"
        static let signUp = "Sign up"
        static let signIn = "Sign in"
        static let welcomeMessage = "Your favorite articles, always at your fingertips"
        static let usernamePlaceholder = "Username"
        static let passwordPlaceholder = "Password"
        static let register = "Register"
        static let createAccount = "Create Account"
        static let requiredFields = "Username and password are required"
        static let registrationFailed = "Registration failed"
        static let ok = "OK"
        static let loginTitle = "Log in"
        static let loginFailed = "Login failed"
        static let login = "Login"
    }
    
    enum Fonts {
        static let extraSmall: CGFloat = 12
        static let small: CGFloat = 14
        static let normal: CGFloat = 16
        static let large: CGFloat = 18
        static let extraLarge: CGFloat = 30
    }
    
    enum Colors {
        static let authorAndDateTextColor = Color(red: 60/255, green: 60/255, blue: 67/255, opacity: 0.6)
        static let summaryTextColor = Color(red: 85/255, green: 85/255, blue: 85/255)
        static let cellBackgroundColor = Color(red: 230/255, green: 229/255, blue: 227/255)
        static let xMarkIconColor = Color.gray
        static let topicCellUnselectedColor = Color.gray.opacity(0.2)
        static let topicCellTextSelectedColor = Color.white
        static let primaryColor = Color.blue
        static let inputFieldBorderColor = Color.gray
        static let buttonTextColor = Color.white
    }
    
    enum Spacing {
        static let extraSmall: CGFloat = 6
        static let small: CGFloat = 10
        static let normal: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 50
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
        static let extraLarge: CGFloat = 40
    }
    
    enum CornerRadius {
        static let extraSmall: CGFloat = 8
        static let small: CGFloat = 10
        static let normal: CGFloat = 12
        static let large: CGFloat = 16
    }
    
    enum Height {
        static let extraSmall: CGFloat = 15
        static let small: CGFloat = 20
        static let normal: CGFloat = 25
        static let large: CGFloat = 40
        static let extraLarge: CGFloat = 70
    }
}

