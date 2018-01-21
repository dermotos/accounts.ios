//
//  Account.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol AccountProtocol {
    
    var balanceInCents : Int64 { get set }
    var currency : Currency { get set }
    var isVisible : Bool { get set }
    var accountId : String { get set }
    var accountNumber : String { get set }
    var alias : String { get set }
    
    init?(withJSON json:JSON)
}

protocol PaymentAccountProtocol : AccountProtocol {
    var type : AccountType { get set }
}

protocol SavingAccountProtocol : AccountProtocol {
    var type : AccountType { get set }
    var linkedAccountId : String { get set }
    var productName : String { get set }
    var productType : Int { get set }
    var savingsTargetReached : Bool { get set }
    var targetAmountInCents : Int64 { get set }
}

