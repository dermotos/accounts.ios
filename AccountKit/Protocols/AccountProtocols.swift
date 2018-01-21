//
//  Account.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol AccountProtocol {
    var type : AccountType { get set }
    var balanceInCents : Int64 { get set }
    var currency : Currency { get set }
    var isVisible : Bool { get set }
    var accountId : String { get set }
    var accountNumber : String { get set }
    var accountName : String { get set }
    var alias : String { get set }
    var iban : String { get set }
    
    init?(withJSON json:JSON)
}

public protocol PaymentAccountProtocol : AccountProtocol { }

public protocol SavingAccountProtocol : AccountProtocol {
    var linkedAccountId : String { get set }
    var productName : String { get set }
    var productType : Int { get set }
    var savingsTargetReached : Bool { get set }
    var targetAmountInCents : Int64 { get set }
}


public protocol CreditCardAccountProtocol : AccountProtocol { }

