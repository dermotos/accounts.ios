//
//  InterfaceController.swift
//  accounts.ios WatchKit Extension
//
//  Created by Dermot O Sullivan on 21/1/18.
//  Copyright © 2018 Rocky Desk Creations. All rights reserved.
//

import WatchKit
import Foundation
import AccountKit_WatchOS


class InterfaceController: WKInterfaceController {
    
    var dataSource : AccountDataSource!

    @IBOutlet var table: WKInterfaceTable!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
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
        
    }
    
    func presentError(withMessage message:String) {
        print("TODO: Present error on watch")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
