//
//  MyOrdersTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 15/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell
{
    @IBOutlet weak var dummyVw: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusVw: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
