//
//  Transaction.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation

struct Transaction: Decodable {
    let partnerDisplayName: String
    let alias: TransactionAlias
    let category: Int
    let transactionDetail: TransactionDetail
}

struct TransactionAlias: Decodable {
    let reference: String
}

struct TransactionDetail: Decodable {
    let description: String?
    let bookingDate: String
    let value: TransactionValue

    var formattedBookingDate: String {
        bookingDate
            .toDate()
            .getFormattedDate(format: "dd.MM.yyyy")
    }
}

struct TransactionValue: Decodable {
    let amount: Float
    let currency: String
}
