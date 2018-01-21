//
//  Account.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

protocol AccountProtocol {
    var type : AccountType? { get set }
    var balanceInCents : Int64? { get set }
    var currency : Currency? { get set }
    var isVisible : Bool? { get set }
    var accountId : String? { get set }
    var accountNumber : String? { get set }
    var alias : String? { get set }
}

protocol SavingAccountProtocol : AccountProtocol {
    var linkedAccountId : String? { get set }
}
