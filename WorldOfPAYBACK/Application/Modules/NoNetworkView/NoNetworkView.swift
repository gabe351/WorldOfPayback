//
//  NoNetworkView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/27/23.
//

import SwiftUI

struct NoNetworkView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(systemName: "wifi.slash")
                    .imageScale(.large)
                    .foregroundColor(.red)

                Text("Network connection seems to be offline. \n Please check your connectivity ")
                    .multilineTextAlignment(.center)
                .padding(.vertical)
                .padding(.horizontal, 32)
            }
        }
    }
}
