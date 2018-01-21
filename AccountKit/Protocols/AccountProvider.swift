//
//  AccountProvider.swift
//  AccountKit
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

protocol AccountProvider {
    func getAccounts(withCompletion completion:AccountProviderResult)
}
