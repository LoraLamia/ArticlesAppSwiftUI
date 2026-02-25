//
//  InputField.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 25.02.2026..
//

import SwiftUI

struct InputField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .focused($isFocused)
            } else {
                TextField(placeholder, text: $text)
                    .focused($isFocused)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.normal)
                .stroke(
                    isFocused ? Constants.Colors.primaryColor : Constants.Colors.inputFieldBorderColor,
                    lineWidth: 1.5
                )
        )
    }
}

#Preview {
    @Previewable @State var username: String = ""

    return InputField(placeholder: "Username", text: $username)
        .padding(Constants.Padding.normal)
}

