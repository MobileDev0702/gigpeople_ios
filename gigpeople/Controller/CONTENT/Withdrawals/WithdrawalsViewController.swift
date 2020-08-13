//
//  WithdrawalsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class WithdrawalsViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func withdrawBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WithdrawalSelectionViewController") as? WithdrawalSelectionViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
