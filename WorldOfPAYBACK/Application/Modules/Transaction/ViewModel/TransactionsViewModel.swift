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

    @Published var transactionList: [Transaction] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading = true

    init(apiDataSource: TransactionsApiDataSource = TransactionsApiDataSourceImplementation()) {
        self.apiDataSource = apiDataSource
    }

    func fetchAll() {
        isLoading = true
        apiDataSource
            .fetchAll()
            .delay(for: 2, scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.message
                }

                self?.isLoading = false
            }, receiveValue: {  [weak self] (response: TransactionResponse) in
                self?.transactionList = response.items
                self?.errorMessage = nil
            })
            .store(in: &disposables)
    }
}
