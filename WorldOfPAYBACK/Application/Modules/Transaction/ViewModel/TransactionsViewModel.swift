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

    init(apiDataSource: TransactionsApiDataSource = TransactionsApiDataSourceImplementation()) {
        self.apiDataSource = apiDataSource
    }

    func fetchAll() {
        apiDataSource
            .fetchAll()?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: {  [weak self] (response: TransactionResponse) in
                self?.transactionList = response.items
            })
            .store(in: &disposables)
    }
}
