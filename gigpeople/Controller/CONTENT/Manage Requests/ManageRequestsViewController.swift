//
//  ManageRequestsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ManageRequestsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableObj: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.tableObj.tableFooterView = UIView()
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    @IBAction func addBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewRequestViewController") as? AddNewRequestViewController
        wc?.getPageFrom = "Add New Request"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("ManageRequestsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? ManageRequestsTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestDetailsViewController") as? RequestDetailsViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
