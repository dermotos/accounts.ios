//
//  PaymentAccountCellViewModelSpec.swift
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

class PaymentAccountCellViewModelSpec : QuickSpec {
    
    override func spec() {
        
        var testPaymentAccount :PaymentAccount!
        
        beforeEach {
            let testBundle = Bundle(for: type(of: self))
            let filePath = testBundle.path(forResource: "testpayment", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                let text = try String(contentsOfFile: filePath!)
                let json = JSON(parseJSON: text)
                testPaymentAccount = PaymentAccount(withJSON: json)
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
        }
        
        describe("PaymentAccountCellViewModel") {
            it("should initialize from a PaymentAccount object") {
                let viewModel = PaymentAccountCellViewModel(with: testPaymentAccount)
                expect(viewModel).toNot(beNil())
            }
            
            it("should have a primary text field equal to the account alias if set") {
                testPaymentAccount.alias = "Test Alias Value"
                let viewModel = PaymentAccountCellViewModel(with: testPaymentAccount)
                expect(viewModel.primaryAccountLabelText).to(equal("Test Alias Value"))
            }
            
            it("should have a primary text field equal to the account name if alias not set") {
                testPaymentAccount.alias = ""
                testPaymentAccount.accountName = "Test Account Name"
                let viewModel = PaymentAccountCellViewModel(with: testPaymentAccount)
                expect(viewModel.primaryAccountLabelText).to(equal("Test Account Name"))
            }
            
            // Limiting to a few unit tests for the purposes of this example
        }
    }
}
