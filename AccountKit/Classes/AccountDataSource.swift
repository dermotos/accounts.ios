//
//  AccountDataSource.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

protocol AccountDataSourceProtocol : class {
    
    init?(withAccounts accounts:[AccountProtocol])
    
    func numberOfAccountGroups() -> Int
    func numberOfAccountsInGroup(atIndex groupIndex:Int) -> Int
    func typeOfAccount(atIndex groupIndex:Int) -> AccountType
    
    func viewModel(forGroup groupIndex: Int, atIndex itemIndex: Int) -> AccountCellViewModel
    
}

class AccountDataSource : AccountDataSourceProtocol {
    
    private lazy var viewModels = [[AccountCellViewModel]]()
    private lazy var accountTypes = [AccountType]()
    
    required init?(withAccounts accounts: [AccountProtocol]) {
        
        for account in accounts {
            // Create the view model from the account data:
            var accountViewModel :AccountCellViewModel!
            switch account.type {
            case .payment:
                accountViewModel = PaymentAccountCellViewModel(with: account as! PaymentAccountProtocol)
            case .saving:
                accountViewModel = SavingAccountCellViewModel(with: account as! SavingAccountProtocol)
            case .creditCard:
                fatalError("Credit cards not supported in this example")
            }
            
            // Insert it into the 2 dimensional array at the correct position:
            
            if let index = accountTypes.index(of: account.type) {
                viewModels[index].append(accountViewModel)
            }
            else {
                viewModels.append([accountViewModel])
                accountTypes.append(account.type)
            }
        }
    }
    
    func numberOfAccountGroups() -> Int {
        return accountTypes.count
    }
    
    func numberOfAccountsInGroup(atIndex groupIndex: Int) -> Int {
        return viewModels[groupIndex].count
    }
    
    func typeOfAccount(atIndex groupIndex: Int) -> AccountType {
        return accountTypes[groupIndex]
    }
    
    func viewModel(forGroup groupIndex: Int, atIndex itemIndex: Int) -> AccountCellViewModel {
        return viewModels[groupIndex][itemIndex]
    }
    
    
    
    
}
