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
            VStack(spacing: 0) {
                Text(transaction.partnerDisplayName)
                    .font(.largeTitle.bold())
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)

                Text(AppStrings.descriptionTitle)
                    .font(.title3)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)

                Text(transaction.transactionDetail.description?.localized ?? AppStrings.emptyDescription)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding(.leading)
        }
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionDetailView(transaction: Transaction(
                partnerDisplayName: "Aral",
                alias: TransactionAlias(reference: "1234"),
                category: 2,
                transactionDetail: TransactionDetail(
                    description: "This is a short description",
                    bookingDate: "10.11.1994",
                    value: TransactionValue(amount: 125.0, currency: "PBP"))
            ))
            .previewDisplayName("Short description")

            TransactionDetailView(transaction: Transaction(
                partnerDisplayName: "Aral",
                alias: TransactionAlias(reference: "1234"),
                category: 2,
                transactionDetail: TransactionDetail(
                    description: "Mussum Ipsum, cacilds vidis litro abertis. A ordem dos tratores não altera o pão duris.Quem num gosta di mim que vai caçá sua turmis!Copo furadis é disculpa de bebadis, arcu quam euismod magna.Manduma pindureta quium dia nois paga.",
                    bookingDate: "10.11.1994",
                    value: TransactionValue(amount: 125.0, currency: "PBP"))
            ))
            .previewDisplayName("Long description")

            TransactionDetailView(transaction: Transaction(
                partnerDisplayName: "Aral",
                alias: TransactionAlias(reference: "1234"),
                category: 2,
                transactionDetail: TransactionDetail(
                    description: nil,
                    bookingDate: "10.11.1994",
                    value: TransactionValue(amount: 125.0, currency: "PBP"))
            ))
            .previewDisplayName("Np description")
        }
    }
}
