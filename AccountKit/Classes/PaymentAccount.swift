//
//  File.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PaymentAccount : PaymentAccountProtocol {
    public var balanceInCents: Int64
    
    public var currency: Currency
    
    public var isVisible: Bool
    
    public var accountId: String
    
    public var accountNumber: String
    
    public var accountName: String
    
    public var alias: String
    
    public var type: AccountType
    
    public var iban : String
    
    public required init?(withJSON json:JSON) {

        guard
            let _accountTypeString = json["accountType"].string,
            let _balanceInCents = json["accountBalanceInCents"].int64,
            let _currency = json["accountCurrency"].string,
            let _isVisible = json["isVisible"].bool,
            let _accountId = json["accountId"].string,
            let _accountNumber = json["accountNumber"].string,
            let _accountName = json["accountName"].string,
            let _iban = json["iban"].string,
            let _alias = json["alias"].string else {
                return nil
        }
        
        guard let accountType = AccountType(rawValue: _accountTypeString) else {
            return nil
        }
        type = accountType
        balanceInCents = _balanceInCents
        if let currencyType = Currency(rawValue: _currency) {
            currency = currencyType
        }
        else { return nil }
        isVisible = _isVisible
        accountId = _accountId
        accountName = _accountName
        accountNumber = _accountNumber
        iban = _iban
        alias = _alias
    }
}

