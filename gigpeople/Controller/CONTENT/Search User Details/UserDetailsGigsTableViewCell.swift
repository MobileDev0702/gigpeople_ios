//
//  UserDetailsGigsTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 07/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class UserDetailsGigsTableViewCell: UITableViewCell {

    @IBOutlet weak var sliderVw: UIView!
    @IBOutlet weak var ratingVw: TPFloatRatingView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
