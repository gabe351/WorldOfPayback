//
//  CategoryTagView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import SwiftUI

struct CategoryTagView: View {

    private let indicatorText: String
    private let color: Color

    init(indicatorText: String, color: Color) {
        self.indicatorText = indicatorText
        self.color = color
    }

    var body: some View {
        Text(indicatorText)
            .foregroundColor(color)
            .padding()
            .overlay(
                Circle()
                .stroke(color, lineWidth: 4)
                .padding(2)
            )
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryTagView(
                indicatorText: "1",
                color: .blue
            )
            .previewDisplayName("Category 1")

            CategoryTagView(
                indicatorText: "2",
                color: .green
            )
            .previewDisplayName("Category 2")

            CategoryTagView(
                indicatorText: "3",
                color: .orange
            )
            .previewDisplayName("Category 3")

        }

    }
}
