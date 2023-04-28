//
//  DateExtension.swift
//  WorldOfPAYBACK
//
//  Created by Gabriel Rosa on 4/28/23.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
