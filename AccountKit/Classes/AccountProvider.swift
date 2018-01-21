//
//  AccountProvider.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import SwiftyJSON

class AccountProvider : AccountProviderProtocol {
    required init?(with json: JSONString) {
        
    }
    
    func getAccounts(withCompletion completion: (Bool, AccountProviderError?, [AccountProtocol]?) -> ()) {
        
    }
    
    
}
