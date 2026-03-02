//
//  NetworkClient.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 02.03.2026..
//

import Combine
import Foundation

final class NetworkClient: NetworkClientContract {
    
    func request<T: Decodable>(_ endpoint: ArticlesEndpoint, responseType: T.Type) -> AnyPublisher<T, Error> {
        var components = URLComponents(
            string: Constants.API.baseURL + endpoint.path
        )
        
        components?.queryItems = endpoint.queryItems
        
        guard let url = components?.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
                
        if endpoint.requiresAuth {
            guard let token = KeychainManager.getToken() else {
                return Fail(error: URLError(.userAuthenticationRequired))
                    .eraseToAnyPublisher()
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                guard (200..<300).contains(response.statusCode) else {
                    throw NSError(domain: "HTTPError", code: response.statusCode)
                }
                
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
