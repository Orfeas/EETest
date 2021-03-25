//
//  String+Additions.swift
//  FootballLeague
//
//  Created by Orfeas Iliopoulos on 25/3/21.
//

import Foundation

extension Date {
    func systemDateOnlyFormat() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self as Date)
    }
}
