//
//  DraftGigDetailsViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 14/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit

class DraftGigDetailsViewController: UIViewController,TPFloatRatingViewDelegate {

    @IBOutlet weak var ratingVw: TPFloatRatingView!
    @IBOutlet weak var bannerVw: UIView!
    @IBOutlet var scrollObj: UIScrollView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let starRatingView = TPFloatRatingView(frame: (self.ratingVw.frame))
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
        self.scrollObj.addSubview(starRatingView)
        
        let arrEmpty = ["banner_one","banner1","banner2","banner3"]
        let nibContents = Bundle.main.loadNibNamed("ImageSliderView", owner: nil, options: nil)
        var objImageSliderView:ImageSliderView!
        objImageSliderView = (nibContents!.last! as! ImageSliderView)
        objImageSliderView.frame = (self.bannerVw.bounds)
        objImageSliderView.pageControl.isHidden = true
        self.bannerVw.addSubview(objImageSliderView)
        let swiftArray = NSArray(array: arrEmpty) as? [String]
        objImageSliderView.initialize(arrImages: swiftArray!)
        objImageSliderView.TimerStart()
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareBtn(_ sender: Any)
    {
        print("Invite Friends")
        let theMessage = "gigpeople App Invite"
        let items = [theMessage]
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        presentActivityController(controller)
    }
    func presentActivityController(_ controller: UIActivityViewController?)
    {
        controller?.modalPresentationStyle = .popover
        if let controller = controller
        {
            present(controller, animated: true)
        }
        let popController: UIPopoverPresentationController? = controller?.popoverPresentationController
        popController?.permittedArrowDirections = .any
        popController?.barButtonItem = navigationItem.leftBarButtonItem
        controller?.completionWithItemsHandler =
            { activityType, completed, returnedItems, error in
                if completed
                {
                    print("Shared")
                }
                else
                {
                    print("We didn't want to share anything after all.")
                }
                if error != nil {
                    print("An Error occured: \(error?.localizedDescription ?? ""), \((error as NSError?)?.localizedFailureReason ?? "")")
                }
        }
    }
    @IBAction func editBtn(_ sender: Any)
    {
        let wc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewGigViewController") as? AddNewGigViewController
        wc?.getPageFrom = "Edit New Gig"
        if let wc = wc
        {
            navigationController?.pushViewController(wc, animated: true)
        }
    }
    @IBAction func publishBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
