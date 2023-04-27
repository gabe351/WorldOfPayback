//
//  AlertView.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import SwiftUI

struct AlertView: View {
    private let iconSystemName: String
    private let iconColor: Color
    private let message: String
    private let actionButtonTitle: String?
    private let action: (() -> Void)?

    init(iconSystemName: String, iconColor: Color = .red, message: String, actionButtonTitle: String? = nil, action: (() -> Void)? = nil) {
        self.iconSystemName = iconSystemName
        self.iconColor = iconColor
        self.message = message
        self.actionButtonTitle = actionButtonTitle
        self.action = action
    }


    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(systemName: iconSystemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64.0, height: 64.0)
                    .foregroundColor(iconColor)

                Text(message)
                    .multilineTextAlignment(.center)
                .padding(.vertical)
                .padding(.horizontal, 32)


                if let title = actionButtonTitle {
                    Button(title) {
                        action?()
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }

            }
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertView(
                iconSystemName: "wifi.slash",
                iconColor: .yellow,
                message: "Network connection seems to be offline.\nPlease check your connectivity"
            )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Preview no connection")

            AlertView(
                iconSystemName: "exclamationmark.octagon.fill",
                message: "We are not able to display transactions right now, try again later \n\n Reason: Mocked error",
                actionButtonTitle: "Try again"
            )
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Preview error message")
        }
    }
}
