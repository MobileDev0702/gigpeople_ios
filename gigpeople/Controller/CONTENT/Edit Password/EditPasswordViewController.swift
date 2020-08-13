//
//  EditPasswordViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 12/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class EditPasswordViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
