//
//  ReviewsTableViewCell.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 08/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

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
