//
//  CurrencyFormatterSpec.swift
//  AccountKitTests
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import AccountKit

class CurrencyFormatterSpec: QuickSpec {
    
    override func spec() {

        describe("Currency formatter ") {
            it("should format currency for The Netherlands as €10,00") {
                let testAmount :Int64 = 1000
                let formattedAmount = testAmount.asCurrencyString(forLocale: Locale(identifier: "nl_nl"))
                expect(formattedAmount).to(beginWith("€"))
                expect(formattedAmount).to(endWith("10,00"))
            }
            
            it("should format currency for The USA as $10.00") {
                let testAmount :Int64 = 1000
                let formattedAmount = testAmount.asCurrencyString(forLocale: Locale(identifier: "en_us"))
                expect(formattedAmount).to(equal("$10.00"))
            }
        }
    }
}
