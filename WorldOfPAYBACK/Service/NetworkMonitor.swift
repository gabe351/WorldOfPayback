//
//  NetworkMonitor.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/27/23.
//

import Network
import Foundation
import Combine

enum NetworkStatus: String {
    case connected
    case disconnected
}

class NetworkMonitor: ObservableObject {

    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "NetworkMonitor")
    @Published var status: NetworkStatus = .connected

    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.status = path.status ==
                    .satisfied ? .connected : .disconnected
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
