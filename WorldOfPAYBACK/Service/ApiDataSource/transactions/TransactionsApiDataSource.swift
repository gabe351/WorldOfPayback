//
//  TransactionsApiDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation
import Combine

protocol TransactionsApiDataSource: AnyObject {
    func fetchAll() -> AnyPublisher<TransactionResponse, Error>?
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


    func fetchAll() -> AnyPublisher<TransactionResponse, Error>? {
        guard let baseUrl = ProcessInfo.processInfo.environment["base_url"],
              let url = URL(string: baseUrl + Endpoints.listAll.path) else {
            // Return an publisher with error message
            print("Fail to load URL")
            return nil
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
//            .eraseToAnyPublisher()
    }

    private func decodeWithRandomlyFail() -> AnyPublisher<TransactionResponse, Error> {
       Bool.random()
        ? Fail(error: NetworkError.connectionError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        : Bundle.main.decodeable(fileName: "PBTransactions.json")
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
