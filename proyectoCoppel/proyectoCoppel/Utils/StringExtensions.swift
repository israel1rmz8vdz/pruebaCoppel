//
//  StringExtensions.swift
//  proyectoCoppel
//
//  Created by Israel Macbook on 04/03/23.
//

import Foundation
import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
