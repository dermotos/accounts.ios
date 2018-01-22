//
//  AccountCellViewModel.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

public protocol AccountCellViewModel {
    var primaryAccountLabelText : String { get set }
    var secondaryAccountLabelText : String { get set }
    var formattedBalance : String { get set }
    var isVisible : Bool { get set }
    var accountNumber : String { get set }
    var iban : String { get set }
    var type :AccountType { get set }
}
