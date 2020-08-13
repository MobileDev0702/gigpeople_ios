//
//  ForgotViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 04/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController,UITextFieldDelegate {

     @IBOutlet weak var emailFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func submit(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func back(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }

}
