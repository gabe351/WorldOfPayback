//
//  TransactionDetailView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import SwiftUI

struct TransactionDetailView: View {
    private let transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var body: some View {
        NavigationView {

            VStack {
                Text("Partner name: " + transaction.partnerDisplayName)
                Text("Description: " + (transaction.transactionDetail.description ?? "None description provided"))
            }
            .navigationBarTitle("Transactions", displayMode: .inline)
        }
    }
}
