//
//  AccountProvider.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

/** Handles loading a collection of accounts from JSON and creating objects to represent them */
public class AccountProvider : AccountProviderProtocol {
    
    let data :JSON
    var errorMessage : String?

    lazy var accounts = [AccountProtocol]()
    
    required public init?(with jsonString: JSONString) {
        data = JSON(parseJSON: jsonString)
        if !dataIsValid { return nil }
    }
    
    private var dataIsValid : Bool {
        // The data source is expected to be a dictionary
        guard data.type == .dictionary else { return false }
        // The 'returnCode' field should equal 'OK'
        guard data["returnCode"] == "OK" else { return false }
        // The accounts array should exist in the payload
        guard data["accounts"] != JSON.null else { return false }
        // The accounts array should contain at least one account
        guard data["accounts"].count > 0 else { return false }
        
        return true
    }
    
    private func deserialize() {
        
        let allAccountsJSON = data["accounts"]
        
        for thisAccountJSON in allAccountsJSON {
            if let accountTypeString = thisAccountJSON.1["accountType"].string,
                let accountType = AccountType(rawValue: accountTypeString) {
                
                switch accountType {
                case .payment:
                    if let account = PaymentAccount(withJSON: thisAccountJSON.1) {
                        accounts.append(account)
                    }
                    else {
                        errorMessage = "Problem parsing Payment Account data at index \(thisAccountJSON.0)"
                        break
                    }
                case .saving:
                    if let account = SavingAccount(withJSON: thisAccountJSON.1) {
                        accounts.append(account)
                    }
                    else {
                        errorMessage = "Problem parsing Saving Account data at index \(thisAccountJSON.0)"
                        break
                    }
                case .creditCard:
                    fatalError("Not implemented, as outside scope of project")
                }
            }
            else {
                errorMessage = "Invalid JSON"
                break
            }
        }
    }
    
    public func getAccounts(withCompletion completion: AccountProviderResult) {
    /* Note:
         Whilst this code is computationaly simple and could execute synchronously, returning the data immediately;
         such a setup is uncommon in the real world as we often have to wait for network calls, etc.
         Therefore, this method returns its results via an async callback, as an example of how I would
         develop this for a real world problem.
    */
        deserialize()
        
        guard errorMessage == nil else {
            // An error occurred during initialisation
            let error = AccountProviderError.parsingError(errorMessage)
            completion(false, error, nil)
            return
        }
        
        completion(true, nil, accounts)
        
    }
    

    
    
}
