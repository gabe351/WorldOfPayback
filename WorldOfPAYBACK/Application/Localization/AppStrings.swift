//
//  AppStrings.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/30/23.
//

import SwiftUI

struct AppStrings {
    static let transactionsTitle: LocalizedStringKey = "transactions.title"
    static let noInternetMessage: LocalizedStringKey = "no.internet.message"
    static let tryAgain: LocalizedStringKey = "try.again"
    static let allCategories: LocalizedStringKey = "all.categories"
    static let filterCategory: LocalizedStringKey = "filter.category"
    static let loading: LocalizedStringKey = "loading.message"
    static let emptyDescription: LocalizedStringKey = "empty.description.message"
    static let descriptionTitle: LocalizedStringKey = "description.title"

    static func errorMessage(_ reason: String) -> LocalizedStringKey { "error.message \(reason)" }
    static func totalAmount(_ value: String) -> LocalizedStringKey { "total.amount \(value)" }
    static func categoryMessage(_ value: Int) -> LocalizedStringKey { "category.message \(value)" }
    static func bookingDate(_ date: String) -> LocalizedStringKey { "booking.date.text \(date)" }
}
