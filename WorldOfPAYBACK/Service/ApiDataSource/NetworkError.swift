//
//  NetworkError.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/26/23.
//

import Foundation

enum NetworkError: Error {
    case generic(Error)
    case connectionError(String)

    var message: String {
        switch self {
        case .generic(let error):
            return error.localizedDescription
        case .connectionError(let value):
            return value
        }
    }
}
