//
//  ReviewsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 08/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TPFloatRatingViewDelegate
{    
    @IBOutlet weak var tableObj: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableObj.tableFooterView = UIView()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var nib = Bundle.main.loadNibNamed("ReviewsTableViewCell", owner: self, options: nil)
        let cell = nib?[0] as? ReviewsTableViewCell
        cell?.selectionStyle =  UITableViewCell.SelectionStyle.none
        
        let starRatingView = TPFloatRatingView(frame: (cell?.ratingVw.frame)!)
        starRatingView.delegate = self
        starRatingView.emptySelectedImage = UIImage(named: "foregroundStar")
        starRatingView.fullSelectedImage = UIImage(named: "backgroundStar")
        starRatingView.contentMode = UIView.ContentMode.scaleAspectFill
        starRatingView.maxRating = 5
        starRatingView.minRating = 0
        starRatingView.rating = 3.0
        starRatingView.editable = false
        starRatingView.halfRatings = true
        starRatingView.floatRatings = false
        cell?.contentView.addSubview(starRatingView)
    
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
}
