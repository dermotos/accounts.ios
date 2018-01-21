//
//  SavingAccountCellViewModel.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

class SavingAccountCellViewModel : AccountCellViewModel {
    var primaryAccountLabelText : String
    var secondaryAccountLabelText : String
    var formattedBalance : String
    var isVisible : Bool
    var accountNumber : String
    var iban : String
    var linkedAccountNumber : String
    var productName : String
    var savingsTargetReached : Bool
    var savingsTargetFormatted : String
    
    var percentTowardsTarget : Float
    
    
    required init(with account:SavingAccountProtocol) {
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
        savingsTargetFormatted = account.targetAmountInCents.asCurrencyString(forLocale: Locale(identifier: "nl_nl"))
        isVisible = account.isVisible
        productName = account.productName
        savingsTargetReached = account.savingsTargetReached
        linkedAccountNumber = account.linkedAccountId
        accountNumber = account.accountNumber
        iban = account.iban
        
        if account.balanceInCents >= account.targetAmountInCents {
            percentTowardsTarget = 1.0
        }
        else {
            percentTowardsTarget = Float(account.balanceInCents) / Float(account.targetAmountInCents)
        }
    }
    
    
}
