//
//  ChatListViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("ChatListTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? ChatListTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        
        if (indexPath.row % 2 == 0)
        {
            cell?.contentView.backgroundColor = UIColor.groupTableViewBackground
        }
        else
        {
            cell?.contentView.backgroundColor = UIColor.white
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
}
