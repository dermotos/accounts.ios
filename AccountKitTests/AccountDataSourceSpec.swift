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
        var testPaymentAccount :PaymentAccount!
        var secondTestPaymentAccount :PaymentAccount!
        
        beforeEach {
            let testBundle = Bundle(for: type(of: self))
            var filePath = testBundle.path(forResource: "testsaving", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                let text = try String(contentsOfFile: filePath!)
                let json = JSON(parseJSON: text)
                
                testSavingAccount = SavingAccount(withJSON: json)
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
            
            filePath = testBundle.path(forResource: "testpayment", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                let text = try String(contentsOfFile: filePath!)
                let json = JSON(parseJSON: text)
                testPaymentAccount = PaymentAccount(withJSON: json)
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
            
            filePath = testBundle.path(forResource: "testpayment", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                let text = try String(contentsOfFile: filePath!)
                let json = JSON(parseJSON: text)
                secondTestPaymentAccount = PaymentAccount(withJSON: json)
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
        }
        
        describe("AccountDataSource") {
            it("should initialize from an array of accounts") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource).toNot(beNil())
            }
            
            it("should have the correct number of account groups when one of each type") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount])
                expect(dataSource?.numberOfAccountGroups()).to(equal(2))
            }
            
            it("should have the correct number of account groups when multiple of an account type") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.numberOfAccountGroups()).to(equal(2))
            }
            
            it("should correctly report the number of items in a group (savings account)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.numberOfAccountsInGroup(atIndex: 0)).to(equal(1)) // 1 savings account
            }
            
            it("should correctly report the number of items in a group (payment accounts)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.numberOfAccountsInGroup(atIndex: 1)).to(equal(2)) // 2 payment account
            }
            
            it("should correctly report the type of account in a group (savings)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.typeOfAccount(atIndex: 0)).to(equal(AccountType.saving)) // 2 payment account
            }
            
            it("should correctly report the type of account in a group (payment)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.typeOfAccount(atIndex: 1)).to(equal(AccountType.payment)) // 2 payment account
            }
            
            it("should correctly provide a view model (saving account)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.viewModel(forGroup: 0, atIndex: 0)).to(beAKindOf(SavingAccountCellViewModel.self)) // saving account
            }
            
            it("should correctly provide a view model (payment account #0)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.viewModel(forGroup: 1, atIndex: 0)).to(beAKindOf(PaymentAccountCellViewModel.self)) // payment account
            }
            
            it("should correctly provide a view model (payment account #1)") {
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource?.viewModel(forGroup: 1, atIndex: 1)).to(beAKindOf(PaymentAccountCellViewModel.self)) // payment account
            }
            
            it("should correctly report the total number of accounts (all accounts)") {
                testSavingAccount.isVisible = true
                testPaymentAccount.isVisible = true
                secondTestPaymentAccount.isVisible = false
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource!.totalNumberOfAccounts(includingHiddenAccounts: true)).to(equal(3))
            }
            
            it("should correctly report the total number of accounts (visible only accounts)") {
                testSavingAccount.isVisible = true
                testPaymentAccount.isVisible = true
                secondTestPaymentAccount.isVisible = false
                let dataSource = AccountDataSource(withAccounts: [testSavingAccount, testPaymentAccount, secondTestPaymentAccount])
                expect(dataSource!.totalNumberOfAccounts(includingHiddenAccounts: false)).to(equal(2))
            }
            

        }
    }
}
