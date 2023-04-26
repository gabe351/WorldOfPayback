//
//  TransactionsApiDataSourceMock.swift
//  WorldOfPAYBACKTests
//
//  Created by Gabriel Rosa on 4/26/23.
//

import Foundation
import Combine
@testable import WorldOfPAYBACK

class TransactionsApiDataSourceMock: TransactionsApiDataSource {

    let fetchSub = PassthroughSubject<TransactionResponse, NetworkError>()

    func fetchAll() -> AnyPublisher<TransactionResponse, NetworkError> {
        fetchSub.eraseToAnyPublisher()
    }
}
