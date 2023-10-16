//
//  Extensions.swift
//  SocialPhotograph
//
//  Created by yacob kazal on 16/10/2023.
//

import Foundation

extension Formatter {
    static var forLocationDegrees: Formatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 10
        formatter.minimumFractionDigits = 0
        formatter.zeroSymbol = ""
        formatter.numberStyle = .decimal
        return formatter
    }
}
