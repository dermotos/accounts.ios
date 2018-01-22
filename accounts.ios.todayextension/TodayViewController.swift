//
//  TodayViewController.swift
//  accounts.ios.todayextension
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import UIKit
import NotificationCenter
import AccountKit

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource : AccountDataSource!
    let compactModeHeight : CGFloat = 110 // This value is set by iOS and is unchangable

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView() // prevents extra dividing bars after last cell
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - UITableViewDataSource protocol conformance
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        var preferredHeight : CGFloat = 0
        switch activeDisplayMode {
        case .compact:
            preferredHeight = compactModeHeight
            
        case .expanded:
            let heightPerRow :CGFloat = 50.0
            if dataSource == nil {
                preferredHeight = compactModeHeight
            }
            else {
                preferredHeight = heightPerRow * CGFloat(totalNumberOfAccounts())
            }
        }
        preferredContentSize = CGSize(width: view.bounds.size.width, height: preferredHeight)
    }
    
    private func totalNumberOfAccounts() -> Int {
        var numberOfAccounts = 0
        for index in 0..<dataSource.numberOfAccountGroups() {
            let accountsInGroup = dataSource.numberOfAccountsInGroup(atIndex: index)
            numberOfAccounts += accountsInGroup
        }
        return numberOfAccounts
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfAccountGroups()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfAccountsInGroup(atIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todayCell", for: indexPath) as! TodayViewCell
        let cellModel = dataSource.viewModel(forGroup: indexPath.section, atIndex: indexPath.row)
        cell.primaryLabel.text = cellModel.primaryAccountLabelText
        cell.secondaryLabel.text = cellModel.type.description
        cell.trailingLabel.text = cellModel.formattedBalance
        return cell
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {

        let dataFilePath = Bundle.main.path(forResource: "accounts", ofType: "json")
        do {
            let jsonString = try String(contentsOfFile: dataFilePath!)
            let accountProvider = AccountProvider(with: jsonString)
            accountProvider?.getAccounts { [weak self] (success, error, accounts) in
                if success && error == nil && accounts != nil {
                    // Ensure self hasn't fallen out of scope during the loading process
                    guard let `self` = self else {
                        completionHandler(NCUpdateResult.failed)
                        return
                    }
                    self.dataSource = AccountDataSource(withAccounts: accounts!)
                    self.dataSource.displayHiddenAccounts = false // To keep the today view simple, only non-hidden accounts are visible
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                    completionHandler(NCUpdateResult.newData)
                }
                else {
                    completionHandler(NCUpdateResult.failed)
                }
            }
        }
        catch {
            completionHandler(NCUpdateResult.failed)
        }
    }
}
