//
//  FavGigTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class FavGigTableViewCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var statusVw: UIView!
    @IBOutlet weak var statusLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
