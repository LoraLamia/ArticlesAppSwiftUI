//
//  RemoteConfigView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 04.03.2026..
//

import SwiftUI
import FirebaseRemoteConfig

struct RemoteConfigView: View {
    @RemoteConfigProperty(key: "text", fallback: "Hello, World!") private var text: String
    
    var body: some View {
        Text(text)
    }
}

#Preview {
    RemoteConfigView()
}

