//
//  TransactionResponse.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation

struct TransactionResponse: Decodable {
    let items: [Transaction]
}
