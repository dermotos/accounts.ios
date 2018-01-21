//
//  SavingAccount.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

public class SavingAccount : SavingAccountProtocol {
    var type: AccountType?
    
    var balanceInCents: Int64?
    
    var currency: Currency?
    
    var isVisible: Bool?
    
    var accountId: String?
    
    var accountNumber: String?
    
    var alias: String?
    
    var linkedAccountId: String?
    
    public init() {
        
    }
    
}
