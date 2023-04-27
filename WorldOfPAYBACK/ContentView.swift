//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationView {
//            if networkMonitor.isConnected {
//                HomeView()
//            } else {
//                NoNetworkView()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
