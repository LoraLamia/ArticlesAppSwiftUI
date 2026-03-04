//
//  AuthEvent.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

enum AuthEvent: AnalyticsEvent {
    case registerTap
    case registerFailure(reason: String)
    case registerSuccess
    
    var eventName: String {
        switch self {
        case .registerTap:
            return "register_tap"
        case .registerFailure:
            return "register_failure"
        case .registerSuccess:
            return "register_success"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .registerFailure(let reason):
            return ["reason": reason]
        default:
            return nil
        }
    }
}
