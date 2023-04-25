//
//  TransactionDetail.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation

struct TransactionDetail: Codable {
    let description: String
    let bookingDate: String
    let value: TransactionValue
}
