//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/27/23.
//

import SwiftUI
import Combine

struct HomeView: View {

    @ObservedObject var viewModel: TransactionsViewModel
    @ObservedObject var networkMonitor: NetworkMonitor
    @State var filterTitle = "Filter category"

    init(viewModel: TransactionsViewModel = TransactionsViewModel(),
         networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.viewModel = viewModel
        self.networkMonitor = networkMonitor
    }

    var body: some View {
        ZStack {
            NavigationView {
                if viewModel.isLoading {
                    Text("Loading")
                } else {
                    transactionListComponent
                        .navigationBarTitle("Transactions", displayMode: .inline)
                }
            }

            if let errorMessage = viewModel.errorMessage {
                AlertView(
                    iconSystemName: "exclamationmark.octagon.fill",
                    message: "We are not able to display transactions right now, try again later \n\n Reason: \(errorMessage)",
                    actionButtonTitle: "Try again"
                ) {
                    viewModel.fetchAll()
                }
            }

            if networkMonitor.status == .disconnected {
                AlertView(
                    iconSystemName: "wifi.slash",
                    message: "Network connection seems to be offline.\nPlease check your connectivity"
                )
            }
        }
        .onAppear(perform: viewModel.fetchAll)
    }

    private var transactionListComponent: some View {
        VStack(alignment: .center) {
            filterComponent

            if let filteredSum = viewModel.transactionAmoundSum {
                Text("Total amount: \(String(format: "%.2f", filteredSum)) PBP")
            }

            List {
                ForEach(viewModel.transactionList, id: \.alias.reference) { element in
                    NavigationLink(destination: TransactionDetailView(transaction: element)) {
                        cell(transaction: element)
                    }
                }
            }
        }
    }

    private var filterComponent: some View {
        VStack {
            Menu {
                Button("All categories") {
                    viewModel.showAll()
                    filterTitle = "All categories"
                }

                ForEach(viewModel.categoryList, id: \.self) { category in
                    Button("\(category)") {
                        viewModel.filterBy(category)
                        filterTitle = "Category: \(category)"
                    }
                }
            } label: {
                Text(filterTitle)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(.green)
        }
    }

    private func cell(transaction: Transaction) -> some View {
        VStack(alignment: .leading) {
            Text(transaction.partnerDisplayName)
                .font(.headline)
            Text(transaction.transactionDetail.bookingDate)
                .foregroundColor(.secondary)
            Text(transaction.transactionDetail.description ?? "No description provided")
                .foregroundColor(.secondary)
            Text("\(String(format: "%.2f", transaction.transactionDetail.value.amount)) \(transaction.transactionDetail.value.currency)")
                .foregroundColor(.secondary)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
