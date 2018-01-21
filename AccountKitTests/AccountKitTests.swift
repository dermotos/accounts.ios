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


class AccountKitSpec: QuickSpec {
    
    override func spec() {
        describe("The datasource") {
            describe("should") {
                it("exist as a json file") {
                    let testBundle = Bundle(for: type(of: self))
                    let filePath = testBundle.path(forResource: "accounts", ofType: "json")
                    expect(filePath).toNot(beNil())
                    let fileExists = FileManager.default.fileExists(atPath: filePath!)
                    expect(fileExists).to(equal(true))
                }
                
                it("be readable") {
                    let testBundle = Bundle(for: type(of: self))
                    let filePath = testBundle.path(forResource: "accounts", ofType: "json")
                    expect(filePath).toNot(beNil())
                    let fileExists = FileManager.default.isReadableFile(atPath: filePath!)
                    expect(fileExists).to(equal(true))
                }
                
                it("be valid JSON") {
                    let testBundle = Bundle(for: type(of: self))
                    let filePath = testBundle.path(forResource: "accounts", ofType: "json")
                    expect(filePath).toNot(beNil())
                    do {
                        let text = try String(contentsOfFile: filePath!)
                        let validJson = JSON(parseJSON: text)
                        expect(validJson.type).toNot(equal(Type.null))
                    }
                    catch {
                        fail("Failed to load file contents located at \(filePath!)")
                    }
                }
            }
        }
    }
}
