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

    init(apiDataSource: TransactionsApiDataSource = TransactionsApiDataSourceImplementation()) {
        self.apiDataSource = apiDataSource
    }

    func fetchAll() {
        apiDataSource
            .fetchAll()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.errorMessage = error.message
                }
            }, receiveValue: {  [weak self] (response: TransactionResponse) in
                self?.transactionList = response.items
                self?.errorMessage = nil
            })
            .store(in: &disposables)
    }
}
