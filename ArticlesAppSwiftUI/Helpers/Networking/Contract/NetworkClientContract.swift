//
//  NetworkClientContract.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 02.03.2026..
//

import Combine

protocol NetworkClientContract {
    func request<T>(_ endpoint: Endpoint, responseType: T.Type) -> AnyPublisher<T, Error> where T : Decodable
}

