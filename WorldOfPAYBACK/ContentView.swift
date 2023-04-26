//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    init(viewModel: TransactionsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")

            ForEach(viewModel.transactionList, id: \.alias.reference) { item in
                Text(item.partnerDisplayName)
            }
        }
        .padding()
        .onAppear(perform: viewModel.fetchAll)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: TransactionsViewModel())
    }
}
