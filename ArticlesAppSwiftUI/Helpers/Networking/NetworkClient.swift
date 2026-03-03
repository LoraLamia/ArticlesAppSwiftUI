//
//  NetworkClient.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 02.03.2026..
//

import Combine
import Foundation

final class NetworkClient: NetworkClientContract {
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, Error> {
        do {
            let request = try endpoint.setUpURLRequest()
            
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
            
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
