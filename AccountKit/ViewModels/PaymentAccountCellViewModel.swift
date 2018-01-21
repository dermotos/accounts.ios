//
//  PaymentAccountCellViewModel.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

class PaymentAccountCellViewModel : AccountCellViewModel {
    var primaryAccountLabelText : String
    var secondaryAccountLabelText : String
    var formattedBalance : String
    var isVisible : Bool
    var accountNumber : String
    var iban : String
    
    required init(with account:PaymentAccountProtocol) {
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
        iban = account.iban
 
    }
    
    
}
