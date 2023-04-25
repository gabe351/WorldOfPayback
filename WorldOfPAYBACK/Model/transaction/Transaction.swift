//
//  Transaction.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation

struct Transaction: Codable {
    let partnerDisplayName: String
    let alias: TransactionAlias
    let category: Int
    let transactionDetail: TransactionDetail
}
