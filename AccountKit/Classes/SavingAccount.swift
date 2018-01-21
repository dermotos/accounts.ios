//
//  SavingAccount.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SavingAccount : SavingAccountProtocol {
    var balanceInCents: Int64
    
    var currency: Currency
    
    var isVisible: Bool
    
    var accountId: String
    
    var accountNumber: String
    
    var alias: String
    
    var type: AccountType
    
    var productName: String
    
    var productType: Int
    
    var savingsTargetReached: Bool
    
    var targetAmountInCents: Int64

    var linkedAccountId: String
    
    public required init?(withJSON json:JSON) {
        
        assert(json["accountType"].string ?? "" == AccountType.saving.rawValue, "Unexpected account type specified")
        self.type = .saving
        
        guard let _balanceInCents = json["accountBalanceInCents"].int64,
            let _currency = json["accountCurrency"].string,
            let _isVisible = json["isVisible"].bool,
            let _accountId = json["accountId"].string,
            let _accountNumber = json["accountNumber"].string,
            let _alias = json["alias"].string,
            let _productName = json["productName"].string,
            let _productType = json["productType"].int,
            let _savingsTargetReached = json["savingsTargetReached"].int,
            let _targetAmountInCents = json["targetAmountInCents"].int64,
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
        alias = _alias
        productName = _productName
        productType = _productType
        savingsTargetReached = _savingsTargetReached == 1 ? true : false
        targetAmountInCents = _targetAmountInCents
        linkedAccountId = _linkedAccountId

    }
    
}
