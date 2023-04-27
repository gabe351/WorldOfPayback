//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/25/23.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {

    @StateObject var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(networkMonitor)
        }
    }
}
