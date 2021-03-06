//
//  SavingAccountCellViewModel.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

/** Represents the prepared information displayed in a Payment Account cell */
public class SavingAccountCellViewModel : AccountCellViewModel {
    public var primaryAccountLabelText : String
    public var secondaryAccountLabelText : String
    public var formattedBalance : String
    public var isVisible : Bool
    public var accountNumber : String
    public var iban : String
    public var linkedAccountNumber : String
    public var productName : String
    public var savingsTargetReached : Bool
    public var savingsTargetFormatted : String
    public var type : AccountType
    public var percentTowardsTarget : Float
    
    
    required public init(with account:SavingAccountProtocol) {
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
        type = account.type
        
        if account.balanceInCents >= account.targetAmountInCents {
            percentTowardsTarget = 1.0
        }
        else {
            percentTowardsTarget = Float(account.balanceInCents) / Float(account.targetAmountInCents)
        }
    }
    
    
}
