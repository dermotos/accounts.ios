//
//  AccountDataSourceSpec.swift
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

class AccountDataSourceSpec : QuickSpec {
    
    override func spec() {
        
        var testSavingAccount :SavingAccount!
        
        beforeEach {
            let testBundle = Bundle(for: type(of: self))
            let filePath = testBundle.path(forResource: "testsaving", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                let text = try String(contentsOfFile: filePath!)
                let json = JSON(parseJSON: text)
                testSavingAccount = SavingAccount(withJSON: json)
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
        }
        
        describe("SavingAccountCellViewModel") {
            it("should initialize from a SavingAccount object") {
                let viewModel = SavingAccountCellViewModel(with: testSavingAccount)
                expect(viewModel).toNot(beNil())
            }
            
            it("should have a primary text field equal to the account alias if set") {
                testSavingAccount.alias = "Test Alias Value"
                let viewModel = SavingAccountCellViewModel(with: testSavingAccount)
                expect(viewModel.primaryAccountLabelText).to(equal("Test Alias Value"))
            }
            
            it("should have a primary text field equal to the account name if alias not set") {
                testSavingAccount.alias = ""
                testSavingAccount.accountName = "Test Account Name"
                let viewModel = SavingAccountCellViewModel(with: testSavingAccount)
                expect(viewModel.primaryAccountLabelText).to(equal("Test Account Name"))
            }
            
            it("should store the progress towards saving target as a number between 0 and 1") {
                testSavingAccount.balanceInCents = 1000
                testSavingAccount.targetAmountInCents = 2000
                let expectedPercentage :Float = 0.5
                let viewModel = SavingAccountCellViewModel(with: testSavingAccount)
                expect(viewModel.percentTowardsTarget).to(equal(expectedPercentage))
            }
            
            it("should store the progress towards saving target as 1.0 if the target is surpassed") {
                testSavingAccount.balanceInCents = 2100
                testSavingAccount.targetAmountInCents = 2000
                let expectedPercentage :Float = 1.0
                let viewModel = SavingAccountCellViewModel(with: testSavingAccount)
                expect(viewModel.percentTowardsTarget).to(equal(expectedPercentage))
            }
            
            // Limiting to a few unit tests for the purposes of this example
        }
    }
}
