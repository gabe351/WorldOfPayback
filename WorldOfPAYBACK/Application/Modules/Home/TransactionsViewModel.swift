//
//  TransactionsViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/26/23.
//

import SwiftUI
import Combine

class TransactionsViewModel: ObservableObject {

    private let apiDataSource: TransactionsApiDataSource
    private var disposables = Set<AnyCancellable>()

    private var orderedTransactionList: [Transaction] = []
    @Published var transactionList: [Transaction] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = true
    @Published var transactionAmoundSum: Float?
    @Published var categoryList: [Int] = []

    init(apiDataSource: TransactionsApiDataSource = TransactionsApiDataSourceImplementation.shared) {
        self.apiDataSource = apiDataSource
    }

    func fetchAll() {
        isLoading = true
        apiDataSource
            .fetchAll()
//            .delay(for: 2, scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.message
                }

                self?.isLoading = false
            }, receiveValue: {  [weak self] (response: TransactionResponse) in
                self?.errorMessage = nil

                self?.orderedTransactionList = response.items
                    .sorted {
                        $0.transactionDetail.bookingDate.toDate()
                            .compare(
                                $1.transactionDetail.bookingDate.toDate()
                            )
                        == .orderedDescending
                    }

                self?.transactionList = self?.orderedTransactionList ?? []

                self?.categoryList = response
                    .items
                    .compactMap { $0.category }
                    .removingDuplicates()
            })
            .store(in: &disposables)
    }

    func filterBy(_ category: Int) {
        self.transactionList = self.orderedTransactionList
            .filter { $0.category == category }
        self.transactionAmoundSum = transactionList
            .compactMap { $0.transactionDetail.value.amount }
            .reduce(Float.zero, +)
    }

    func showAll() {
        self.transactionAmoundSum = nil
        self.transactionList = self.orderedTransactionList
    }
}
