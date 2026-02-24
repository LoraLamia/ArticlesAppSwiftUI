//
//  SearchBarView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 24.02.2026..
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            HStack(spacing: Constants.Spacing.small) {
                TextField(Constants.Strings.searchBarPlaceholder, text: $text)
                    .focused($isFocused)
                
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: Constants.Icons.xMarkName)
                            .foregroundColor(Constants.Colors.xMarkIconColor)
                    }
                }
            }
            .padding(.horizontal, Constants.Padding.small)
            .padding(.vertical, Constants.Padding.extraSmall)
            .background(Color(uiColor: .systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.normal)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .cornerRadius(Constants.CornerRadius.normal)
            .animation(.easeInOut(duration: 0.2), value: text)
        }
    }
}
