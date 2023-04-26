//
//  TransactionsApiDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation
import Combine

protocol TransactionsApiDataSource: AnyObject {
    func fetchAll() -> AnyPublisher<TransactionResponse, NetworkError>
}

class TransactionsApiDataSourceImplementation: TransactionsApiDataSource {

    private enum Endpoints {
        case listAll

        var path: String {
            switch self {
            case .listAll:
                return "/transactions"
            }
        }
    }

    func fetchAll() -> AnyPublisher<TransactionResponse, NetworkError> {
        guard let baseUrl = ProcessInfo.processInfo.environment["base_url"],
              let url = URL(string: baseUrl + Endpoints.listAll.path) else {
            let c = ProcessInfo.processInfo.environment["base_url"] ?? "null"

            return Fail(error: NetworkError.connectionError("Fail to load URL" + c))
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }

        // TODO: Replace bundle decoder with URLSession when API is ready
        return decodeWithRandomlyFail()

//        return URLSession.shared
//            .dataTaskPublisher(for: url)
//            .receive(on: RunLoop.main)
//            .tryMap{ element -> Data in
//                guard let httpResponse = element.response as? HTTPURLResponse,
//                      httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//
//                return element.data
//            }
//            .decode(type: TransactionResponse.self, decoder: JSONDecoder())
//            .mapError { NetworkError.generic($0) }
//            .eraseToAnyPublisher()
    }

    private func decodeWithRandomlyFail() -> AnyPublisher<TransactionResponse, NetworkError> {
       Bool.random()
        ? Fail(error: NetworkError.connectionError("From a random error"))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        : Bundle.main.decodeable(fileName: "PBTransactions.json")
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
