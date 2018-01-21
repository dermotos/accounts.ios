//
//  AccountKitTests.swift
//  AccountKitTests
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Quick
import Nimble
@testable import AccountKit


class AccountKitSpec: QuickSpec {
    
    override func spec() {
        describe("Datasource") {
            it("exists as a json file") {
                
                let testBundle = Bundle(for: type(of: self))
                let filePath = testBundle.path(forResource: "accounts", ofType: "json")
                expect(filePath).toNot(beNil())
                let fileExists = FileManager.default.fileExists(atPath: filePath!)
                expect(fileExists).to(equal(true))
            }
        }
    }
    
}
