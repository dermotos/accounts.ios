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

    var toggleButton : UIButton!
    let buttonText :(toShow:String, toHide :String) = (NSLocalizedString("Show hidden accounts", comment: ""), NSLocalizedString("Hide hidden accounts", comment: ""))
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {

        tableView.tableFooterView = makeFooterView()
        tableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 100)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        
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
                        self.presentError(withMessage: NSLocalizedString("Unable to load account information.", comment: ""))
                    }
                }
            }
        }
        catch {
            presentError(withMessage: NSLocalizedString("Unable to load account information.", comment: ""))
        }
        
    }
    
    private func makeFooterView() -> UIView {
        let footerContainerView = UIView()
        let button = UIButton(type: .custom)
        button.setTitle(buttonText.toShow, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 3.0
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        toggleButton = button

        button.addTarget(self, action: #selector(toggleHiddenAccounts), for: .touchUpInside)
        let buttonFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        button.titleLabel?.font = buttonFont
        footerContainerView.center(subView: button)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 180)
        footerContainerView.addConstraints([heightConstraint,widthConstraint])
        
        return footerContainerView
    }
    
    @objc func toggleHiddenAccounts() {
        tableView.beginUpdates()
        let oldSectionCount = dataSource.numberOfAccountGroups()
        dataSource.displayHiddenAccounts = !dataSource.displayHiddenAccounts
        toggleButton.setTitle(dataSource.displayHiddenAccounts ? buttonText.toHide : buttonText.toShow, for: .normal)
        let newSectionCount = dataSource.numberOfAccountGroups()
        
        // Reload the existing sections, if there were any
        if oldSectionCount > 0 {
            let reloadSet = IndexSet(integersIn: 0...(oldSectionCount - 1))
            tableView.reloadSections(reloadSet, with: .automatic)
        }

        if newSectionCount > oldSectionCount {
            // At least one new section was added
            let insertSet = IndexSet(integersIn: oldSectionCount...(newSectionCount - 1))
            tableView.insertSections(insertSet, with: .automatic)
        }
        else if newSectionCount < oldSectionCount {
            // At least one section was removed
            let removeSet = IndexSet(integersIn: (oldSectionCount - 1)...(newSectionCount - 1))
            tableView.deleteSections(removeSet, with: .automatic)
        }
       
        tableView.endUpdates()
    }
    
    func presentError(withMessage message:String) {
        let alert = UIAlertController(title: NSLocalizedString("An Error Occurred", comment: ""), message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) in
            
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
            let cellViewModel = dataSource.viewModel(forGroup: indexPath.section, atIndex: indexPath.row) as! PaymentAccountCellViewModel
            cell.primaryLabel.text = cellViewModel.primaryAccountLabelText
            cell.secondaryLabel.text = cellViewModel.secondaryAccountLabelText
            cell.amountLabel.text = cellViewModel.formattedBalance
            cell.accountNumberLabel.text = cellViewModel.accountNumber
            cell.ibanLabel.text = cellViewModel.iban
            
            return cell
        case .saving:
            let cell = tableView.dequeueReusableCell(withIdentifier: "savingCell", for: indexPath) as! SavingCell
             let cellViewModel = dataSource.viewModel(forGroup: indexPath.section, atIndex: indexPath.row) as! SavingAccountCellViewModel
            cell.primaryLabel.text = cellViewModel.primaryAccountLabelText
            cell.secondaryLabel.text = cellViewModel.secondaryAccountLabelText
            cell.amountLabel.text = cellViewModel.formattedBalance
            cell.accountNumberLabel.text = cellViewModel.accountNumber
            cell.ibanLabel.text = cellViewModel.iban
            if cellViewModel.savingsTargetReached {
                let targetReachedText = NSLocalizedString("Target Reached", comment: "")
                cell.savingTargetLabel.text = "\(targetReachedText)! - \(cellViewModel.savingsTargetFormatted)"
            }
            else {
                cell.savingTargetLabel.text = cellViewModel.savingsTargetFormatted
            }
            
            cell.savingProgressIndicator.progress = cellViewModel.percentTowardsTarget
            
            return cell
        case .creditCard:
            fatalError("Credit cards not supported in this example")
        }
    }
}
