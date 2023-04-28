//
//  LoadingView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import SwiftUI

struct LoadingView: View {

    private let loadingMessage: String

    init(loadingMessage: String) {
        self.loadingMessage = loadingMessage
    }

    var body: some View {
        NavigationView {
            VStack {
                ProgressView()
                    .scaleEffect(2.0, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
                Text(loadingMessage)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {

    static var previews: some View {
        LoadingView(loadingMessage: "Loading sample...")
    }
}
