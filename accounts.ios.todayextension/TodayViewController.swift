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

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var dataSource : AccountDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        let dataFilePath = Bundle.main.path(forResource: "accounts", ofType: "json")
        do {
            let jsonString = try String(contentsOfFile: dataFilePath!)
            let accountProvider = AccountProvider(with: jsonString)
            accountProvider?.getAccounts { [weak self] (success, error, accounts) in
                if success && error == nil && accounts != nil {
                    dataSource = AccountDataSource(withAccounts: accounts!)
                    
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
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func presentError(withMessage message:String) {
        print("Display error message in today screen")
    }
    
}
