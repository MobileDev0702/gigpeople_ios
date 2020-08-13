//
//  WithdrawalSelectionViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class WithdrawalSelectionViewController: UIViewController {

    @IBOutlet weak var paypalTick: UIImageView!
    @IBOutlet weak var bankTick: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.bankTick.isHidden = true
        self.paypalTick.isHidden = false
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func paypalBtn(_ sender: Any)
    {
        self.bankTick.isHidden = true
        self.paypalTick.isHidden = false
    }
    @IBAction func bankBtn(_ sender: Any)
    {
        self.bankTick.isHidden = false
        self.paypalTick.isHidden = true
    }
}
