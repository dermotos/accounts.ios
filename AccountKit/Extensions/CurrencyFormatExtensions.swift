//
//  CurrencyFormatExtensions.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

extension Int64 {
    
    public func asCurrencyString(forLocale locale:Locale) -> String {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        let amountInWholeUnits :Double = Double(self) / 100.0
        
        if let formattedAmount = formatter.string(from: amountInWholeUnits as NSNumber) {
            return formattedAmount
        }
        else { return "0" }
    }
    
}
