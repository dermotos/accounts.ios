//
//  AccountKitTests.swift
//  AccountKitTests
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

@testable import AccountKit

class AccountKitProviderSpec: QuickSpec {
    
    override func spec() {
        var testJSONString :JSONString!
        
        beforeEach {
            let testBundle = Bundle(for: type(of: self))
            let filePath = testBundle.path(forResource: "testdata", ofType: "json")
            expect(filePath).toNot(beNil())
            do {
                testJSONString = try String(contentsOfFile: filePath!)
                expect(testJSONString).toNot(beNil())
            }
            catch {
                fail("Failed to load file contents located at \(filePath!)")
            }
        }
        
        describe("The testing environment") {
            it("should contain testdata.json") {
                let testBundle = Bundle(for: type(of: self))
                let filePath = testBundle.path(forResource: "testdata", ofType: "json")
                expect(filePath).toNot(beNil())
                let fileExists = FileManager.default.fileExists(atPath: filePath!)
                expect(fileExists).to(equal(true))
            }
        }
        
        
        describe("The AccountProvider class") {
            it("should conform to the AccountProviderProtocol") {
                let testArticle = AccountProvider(with: testJSONString)
                expect(testArticle).to(beAKindOf(AccountProviderProtocol.self))
            }
            
            it("should initialise to a new object with a valid JSON String") {
                let testArticle = AccountProvider(with: testJSONString)
                expect(testArticle).toNot(beNil())
            }
            
            it("should fail initialisation when the JSON is invalid") {
                let brokenJSON = "sdfasfd8934#{{ \(testJSONString)"
                let testArticle = AccountProvider(with: brokenJSON)
                expect(testArticle).to(beNil())
            }
            
            it("if valid, it should callback with success flag set to true") {
                let testArticle = AccountProvider(with: testJSONString)
                var returnedSuccessValue : Bool!
                testArticle?.getAccounts(withCompletion: { (success, error, accounts) in
                    returnedSuccessValue = success
                })
                expect(returnedSuccessValue).toEventually(beTrue())
            }
            
            
        }
    }
}

