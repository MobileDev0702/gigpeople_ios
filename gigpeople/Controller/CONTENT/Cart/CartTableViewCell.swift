//
//  CartTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 09/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var numberFld: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
