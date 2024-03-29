//
//  StringExtension.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/26/23.
//

import SwiftUI

extension String {

    var localized: LocalizedStringKey {
        LocalizedStringKey(self)
    }

    func toDate(withFormat format: String = "yyyy-MM-dd'T'hh:mm:ssZ") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date ?? Date()
    }
}
