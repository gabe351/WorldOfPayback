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
    @State var filterTitle: LocalizedStringKey = AppStrings.filterCategory

    init(viewModel: TransactionsViewModel = TransactionsViewModel(),
         networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.viewModel = viewModel
        self.networkMonitor = networkMonitor
    }

    var body: some View {
        ZStack {
            NavigationView {
                transactionListComponent
                    .navigationBarTitle(AppStrings.transactionsTitle, displayMode: .inline)
            }

            if let errorMessage = viewModel.errorMessage {
                AlertView(
                    iconSystemName: "exclamationmark.octagon.fill",
                    message: AppStrings.errorMessage(errorMessage),
                    actionButtonTitle: AppStrings.tryAgain
                ) {
                    viewModel.fetchAll()
                }
            }

            if viewModel.isLoading {
                LoadingView(loadingMessage: AppStrings.loading)
            }

            if networkMonitor.status == .disconnected {
                AlertView(
                    iconSystemName: "wifi.slash",
                    message: AppStrings.noInternetMessage
                )
            }
        }
        .onAppear(perform: viewModel.fetchAll)
    }

    private var transactionListComponent: some View {
        VStack(alignment: .center) {
            filterComponent

            if let filteredSum = viewModel.transactionAmoundSum {
                Text(AppStrings.totalAmount(filteredSum.stringValue))
            }

            List {
                ForEach(viewModel.transactionList, id: \.alias.reference) { element in
                    ZStack {
                        cell(transaction: element)
                        NavigationLink(destination: TransactionDetailView(transaction: element)) {
                            EmptyView()
                        }.opacity(0)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                    )
                    .listRowSeparator(.hidden)
                }
            }
        }
    }

    private var filterComponent: some View {
        VStack {
            Menu {
                Button(AppStrings.allCategories) {
                    viewModel.showAll()
                    filterTitle = AppStrings.allCategories
                }

                ForEach(viewModel.categoryList, id: \.self) { category in
                    Button("\(category)") {
                        viewModel.filterBy(category)
                        filterTitle = AppStrings.categoryMessage(category)
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
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(transaction.partnerDisplayName)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
                CategoryTagView(category: CategoryType(rawValue: transaction.category) ?? .undefined)
            }

            Text("\(transaction.transactionDetail.value.amount.stringValue) \(transaction.transactionDetail.value.currency)")
                .font(.system(size: 12))
                .fontWeight(.medium)
                .padding(.bottom)

            Text(transaction.transactionDetail.description?.localized ?? AppStrings.emptyDescription)
                .font(.system(size: 16))
                .lineLimit(2)
                .padding(.vertical)

            Text(AppStrings.bookingDate(transaction.transactionDetail.formattedBookingDate))
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
