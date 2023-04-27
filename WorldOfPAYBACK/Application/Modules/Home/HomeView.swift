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
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 2.0)))
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text("Error reason: " + errorMessage)
                    } else {
                        VStack {
                            filterComponent

                            if let filteredSum = viewModel.transactionAmoundSum {
                                Text("Total amount: \(String(format: "%.2f", filteredSum)) PBP")
                            }

                            transactionListComponent
                        }
                        .padding()
                        .navigationBarTitle("List of transactions", displayMode: .inline)
                    }
                }
            }

            if networkMonitor.status == .disconnected {
                NoNetworkView()
            }
        }
        .onAppear(perform: viewModel.fetchAll)
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

    private var transactionListComponent: some View {
        List {
            ForEach(viewModel.transactionList, id: \.alias.reference) { element in
                VStack(alignment: .leading) {
                    Text(element.partnerDisplayName)
                        .font(.headline)
                    Text(element.transactionDetail.bookingDate)
                        .foregroundColor(.secondary)
                    Text(element.transactionDetail.description ?? "No description provided")
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.2f", element.transactionDetail.value.amount)) \(element.transactionDetail.value.currency)")
                        .foregroundColor(.secondary)

                }
            }
        }
    }
}
