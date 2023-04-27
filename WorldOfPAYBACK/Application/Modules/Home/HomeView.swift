//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/27/23.
//

import SwiftUI
import Combine

struct HomeView: View {

    @ObservedObject var viewModel: TransactionsViewModel
    @ObservedObject var networkMonitor: NetworkMonitor

    init(viewModel: TransactionsViewModel = TransactionsViewModel(),
         networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.viewModel = viewModel
        self.networkMonitor = networkMonitor
    }

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                if let errorMessage = viewModel.errorMessage {
                    Text("Error reason: " + errorMessage)
                }

                if viewModel.isLoading {
                    Text("Loading")
                } else {
                    Text("Total amount: \(String(format: "%.2f", viewModel.transactionAmoundSum))")
                }

                ForEach(viewModel.transactionList, id: \.alias.reference) { item in
                    Text(item.partnerDisplayName)
                }
            }
            .padding()

            if networkMonitor.status == .disconnected {
                NoNetworkView()
            }
        }
        .onAppear(perform: viewModel.fetchAll)
    }
}
