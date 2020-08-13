//
//  TermsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController
{
    @IBOutlet weak var headerLbl: UILabel!
    var getPageFrom:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.headerLbl.text = getPageFrom
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
