//
//  UserEndpoint.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 03.03.2026..
//

import Foundation

enum UserEndpoint: Endpoint {
    case login(username: String, password: String)
    case register(username: String, password: String)
    
    var path: String {
        switch self {
        case .login:
            return Constants.API.loginEndpoint
        case .register:
            return Constants.API.registerEndpoint
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .login, .register:
            return nil
        }
    }
    
    var method: String {
        switch self {
        case .login, .register:
            return "POST"
        }
    }
    
    var requiresAuth: Bool {
        switch self {
            case .login, .register:
                return false
        }
    }
    
    var body: [String : Any] {
        switch self {
        case .login(username: let username, password: let password), .register(username: let username, password: let password):
            ["username": username, "password": password]
        }
    }
    
    func setUpURLRequest() throws -> URLRequest {
        var components = URLComponents(
            string: Constants.API.baseURL + path
        )
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
                
        if !body.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        
        return request
    }
}
