//
//  SavingAccount.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

/** Represents a saving account as loaded from Disk/Network */
public class SavingAccount : SavingAccountProtocol {
    public var balanceInCents: Int64
    
    public var currency: Currency
    
    public var isVisible: Bool
    
    public var accountId: String
    
    public var accountNumber: String
    
    public var accountName: String
    
    public var alias: String
    
    public var type: AccountType
    
    public var iban: String
    
    public var productName: String
    
    public var productType: Int
    
    public var savingsTargetReached: Bool
    
    public var targetAmountInCents: Int64

    public var linkedAccountId: String
    
    public required init?(withJSON json:JSON) {
        
        assert(json["accountType"].string ?? "" == AccountType.saving.rawValue, "Unexpected account type specified")
        self.type = .saving
        
        guard let _balanceInCents = json["accountBalanceInCents"].int64,
            let _currency = json["accountCurrency"].string,
            let _isVisible = json["isVisible"].bool,
            let _accountId = json["accountId"].string,
            let _accountNumber = json["accountNumber"].string,
            let _accountName = json["accountName"].string,
            let _alias = json["alias"].string,
            let _productName = json["productName"].string,
            let _productType = json["productType"].int,
            let _savingsTargetReached = json["savingsTargetReached"].int,
            let _targetAmountInCents = json["targetAmountInCents"].int64,
            let _iban = json["iban"].string,
            let _linkedAccountId = json["linkedAccountId"].string else {
                return nil
        }
        
        balanceInCents = _balanceInCents
        if let currencyType = Currency(rawValue: _currency) {
            currency = currencyType
        }
        else { return nil }
        
        isVisible = _isVisible
        accountId = _accountId
        accountNumber = _accountNumber
        accountName = _accountName
        alias = _alias
        iban = _iban
        productName = _productName
        productType = _productType
        savingsTargetReached = _savingsTargetReached == 1 ? true : false
        targetAmountInCents = _targetAmountInCents
        linkedAccountId = _linkedAccountId

    }
    
}
