//
//  TopicCellView.swift
//  ArticlesAppSwiftUI
//
//  Created by Lora Zubić on 27.02.2026..
//

import SwiftUI

struct TopicCellView: View {
    var callback: (() -> Void)?
    var topic: String
    var isSelected: Bool
    
    var body: some View {
        Button {
            callback?()
        } label: {
            Text(topic)
                .padding(.horizontal, Constants.Padding.small)
                .padding(.vertical, Constants.Padding.extraSmall)
                .background(isSelected ? Constants.Colors.primaryColor : Constants.Colors.topicCellUnselectedColor)
                .foregroundColor(isSelected ? Constants.Colors.topicCellTextSelectedColor : Constants.Colors.primaryColor)
                .cornerRadius(Constants.CornerRadius.normal)
        }
    }
}

