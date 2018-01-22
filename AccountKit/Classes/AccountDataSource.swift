//
//  AccountDataSource.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation

/** Defines the interface of the AccountDataSource. The interface is similar to a UITableViewDataSource, making
    It easy to integrate with CollectionViews and TableViews */
public protocol AccountDataSourceProtocol : AnyObject {
    
    init?(withAccounts accounts:[AccountProtocol])
    
    func numberOfAccountGroups() -> Int
    func numberOfAccountsInGroup(atIndex groupIndex:Int) -> Int
    func typeOfAccount(atIndex groupIndex:Int) -> AccountType
    func totalNumberOfAccounts(includingHiddenAccounts includeHidden:Bool) -> Int
    
    func viewModel(forGroup groupIndex: Int, atIndex itemIndex: Int) -> AccountCellViewModel
    
}

/** Provides view models to a view controller for rendering */
public class AccountDataSource : AccountDataSourceProtocol {
    private lazy var visibleViewModels = [[AccountCellViewModel]]()
    private lazy var visibleAccountTypes = [AccountType]()
    
    private lazy var allViewModels = [[AccountCellViewModel]]()
    private lazy var allAccountTypes = [AccountType]()
    
    public var displayHiddenAccounts : Bool = false
    
    required public init?(withAccounts accounts: [AccountProtocol]) {
        
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
            
            // Store the data in two collections. One for all accounts, and one for visible only (isVisible = true)
            if let index = allAccountTypes.index(of: account.type) {
                allViewModels[index].append(accountViewModel)
            }
            else {
                allViewModels.append([accountViewModel])
                allAccountTypes.append(account.type)
            }
            
            if account.isVisible {
                if let index = visibleAccountTypes.index(of: account.type) {
                    visibleViewModels[index].append(accountViewModel)
                }
                else {
                    visibleViewModels.append([accountViewModel])
                    visibleAccountTypes.append(account.type)
                }
            }
        }
    }
    
    public func totalNumberOfAccounts(includingHiddenAccounts includeHidden:Bool) -> Int {
        if includeHidden {
            return allViewModels.flatMap { $0 }.count
        }
        else {
            return visibleViewModels.flatMap { $0 }.count
        }
    }
    
    public func numberOfAccountGroups() -> Int {
        return displayHiddenAccounts ? allAccountTypes.count : visibleAccountTypes.count
    }
    
    public func numberOfAccountsInGroup(atIndex groupIndex: Int) -> Int {
        return displayHiddenAccounts ? allViewModels[groupIndex].count : visibleViewModels[groupIndex].count
    }
    
    public func typeOfAccount(atIndex groupIndex: Int) -> AccountType {
        return displayHiddenAccounts ? allAccountTypes[groupIndex] : visibleAccountTypes[groupIndex]
    }
    
    public func viewModel(forGroup groupIndex: Int, atIndex itemIndex: Int) -> AccountCellViewModel {
        return displayHiddenAccounts ? allViewModels[groupIndex][itemIndex] : visibleViewModels[groupIndex][itemIndex]
    }
}
