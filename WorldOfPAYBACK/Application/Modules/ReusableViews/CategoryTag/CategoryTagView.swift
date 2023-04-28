//
//  CategoryTagView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import SwiftUI

enum CategoryType: Int {
    case one = 1
    case two = 2
    case three = 3
    case undefined

    public var categoryText: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .undefined:
            return "?"
        }
    }

    public var categoryColor: Color {
        switch self {
        case .one:
            return .indigo
        case .two:
            return .green
        case .three:
            return .orange
        case .undefined:
            return .gray
        }
    }
}

struct CategoryTagView: View {

    private let category: CategoryType

    init(category: CategoryType) {
        self.category = category
    }

    var body: some View {
        Text(category.categoryText)
            .foregroundColor(category.categoryColor)
            .font(.system(size: 10).bold())
            .padding(8)
            .overlay(
                Circle()
                    .stroke(category.categoryColor, lineWidth: 2)
            )
    }
}

struct CategoryTagView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryTagView(category: .one)
            .previewDisplayName("Category 1")

            CategoryTagView(category: .two)
            .previewDisplayName("Category 2")

            CategoryTagView(category: .three)
            .previewDisplayName("Category 3")

            CategoryTagView(category: CategoryType(rawValue: 1231) ?? .undefined)
            .previewDisplayName("Category Undefined")
        }

    }
}
