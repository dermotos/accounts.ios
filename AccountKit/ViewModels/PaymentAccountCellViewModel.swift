//
//  PaymentAccountCellViewModel.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

public class PaymentAccountCellViewModel : AccountCellViewModel {
    public var primaryAccountLabelText : String
    public var secondaryAccountLabelText : String
    public var formattedBalance : String
    public var isVisible : Bool
    public var accountNumber : String
    public var iban : String
    public var type : AccountType
    
    required public init(with account:PaymentAccountProtocol) {
    /* we shall assume the following priority for identifying an account from the perspective
        of the user:
        alias, accountName, accountNumber
    */
        if account.alias.count > 0 {
            primaryAccountLabelText = account.alias
            if account.accountName.count > 0 {
               secondaryAccountLabelText = "\(account.accountName) - \(account.accountNumber)"
            }
            else {
                secondaryAccountLabelText = account.accountNumber
            }
        }
        else {
            if account.accountName.count > 0 {
                primaryAccountLabelText = account.accountName
                secondaryAccountLabelText = account.accountNumber
            }
            else {
                primaryAccountLabelText = account.accountNumber
                secondaryAccountLabelText = ""
            }
        }
        
        formattedBalance = account.balanceInCents.asCurrencyString(forLocale: Locale(identifier: "nl_nl"))
        isVisible = account.isVisible
        accountNumber = account.accountNumber
        type = account.type
        iban = "IBAN: \(account.iban)"
 
    }
    
    
}
