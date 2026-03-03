//
//  Endpoint.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 03.03.2026..
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: String { get }
    var requiresAuth: Bool { get }
    var body: [String : Any] { get }
    
    func setUpURLRequest() throws -> URLRequest
}

