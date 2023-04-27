//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/27/23.
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: TransactionsViewModel

    init(viewModel: TransactionsViewModel = TransactionsViewModel()) {
        self.viewModel = viewModel
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
                    Text("Loaded - Total amount: \(String(format: "%.2f", viewModel.transactionAmoundSum))")
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
