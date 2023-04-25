//
//  TransactionsApiDataSource.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import Foundation

protocol TransactionsApiDataSource: AnyObject {
    func fetchAll()
}

class TransactionsApiDataSourceImplementation: TransactionsApiDataSource {

    private enum endpoints {
        case listAll

        var path: String {
            switch self {
            case .listAll:
                return "/transactions"
            }
        }
    }


    func fetchAll() {
        guard let baseUrl = ProcessInfo.processInfo.environment["base_url"] else {
            return print("Fail to request: nil base URL")
        }

        // TODO: Replace mock code with API implementation

    }
}
