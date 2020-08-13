//
//  SubCategoryDetailsTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 10/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class SubCategoryDetailsTableViewCell: UITableViewCell
{

    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var sliderVw: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
