//
//  MainTableViewController.swift
//  accounts.ios
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import Foundation
import UIKit
import AccountKit

class MainTableViewController : UITableViewController {
    
    var dataSource : AccountDataSource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView() // Remove the divider bars after the last displayed cell
        let dataFilePath = Bundle.main.path(forResource: "accounts", ofType: "json")
        do {
            let jsonString = try String(contentsOfFile: dataFilePath!)
            let accountProvider = AccountProvider(with: jsonString)
            accountProvider?.getAccounts { [weak self] (success, error, accounts) in
                if success && error == nil && accounts != nil {
                    dataSource = AccountDataSource(withAccounts: accounts!)
                    if let `self` = self {
                        self.tableView.reloadData()
                    }
                }
                else {
                    if let `self` = self {
                        self.presentError(withMessage: "Unable to load account information.")
                    }
                }
            }
        }
        catch {
            presentError(withMessage: "Unable to load account information.")
        }
        
    }
    
    func presentError(withMessage message:String) {
        let alert = UIAlertController(title: "An Error Occurred", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let dataSource = dataSource else { return 0 }
        return dataSource.numberOfAccountGroups()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.typeOfAccount(atIndex: section).description
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfAccountsInGroup(atIndex: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupType = dataSource.typeOfAccount(atIndex: indexPath.section)
        switch groupType {
        case .payment:
            let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! PaymentCell
            cell.primaryLabel.text = "Testing"
            return cell
        case .saving:
            let cell = tableView.dequeueReusableCell(withIdentifier: "savingCell", for: indexPath) as! SavingCell
            cell.primaryLabel.text = "Testing"
            return cell
        case .creditCard:
            fatalError("Credit cards not supported in this example")
        }
    }
    
}
