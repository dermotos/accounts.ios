//
//  AccountProvider.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation


public typealias JSONString = String

public protocol AccountProviderProtocol {
    
    init?(with json:JSONString)
    func getAccounts(withCompletion completion:AccountProviderResult)
}
