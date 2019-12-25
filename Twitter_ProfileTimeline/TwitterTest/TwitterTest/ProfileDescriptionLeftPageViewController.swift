//
//  ProfileDescriptionLeftPageViewController.swift
//  TwitterTest
//
//  Created by Константин on 07.04.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class ProfileDescriptionLeftPageViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var logOutButton: UIButton!
    
    var user: User! {
        didSet {
            configureViewController()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName("ProfileConfigureSubviews", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            if User.tempUser != nil {
                self.user = User.tempUser
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if User.tempUser != nil {
            self.user = User.tempUser
        }
    }
    
    func configureViewController() {
        
        NSNotificationCenter.defaultCenter().postNotificationName("ProfileConfigureRightSubviews", object: nil)
        
        let name = user.name
        let screenname = user.screenname
        let location = user.locationString
        let followingCount = user.followingCount
        let followersCount = user.followersCount
        
        nameLabel.text = String(name!)
        
        screenNameLabel.text = String(screenname!)
        locationLabel.text = String(location!)
        
        followersCountLabel.text = shortenNumber(Double(followersCount!))
        followingCountLabel.text = shortenNumber(Double(followingCount!))
        
        if user.screenname != User.currentUser?.screenname {
            logOutButton.hidden = true
        } else {
            logOutButton.hidden = false
        }
    }
    
    func shortenNumber(var number: Double) -> String {
        if number > 999999999 {
            number = number / 1000000000
            return String(format: "%.1f", number) + "B"
        }
        
        if number > 999999 {
            number = number / 1000000
            return String(format: "%.1f", number) + "M"
        }
        
        if number > 9999 {
            number = number / 1000
            return String(format: "%.1f", number) + "K"
        }
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        return numberFormatter.stringFromNumber(number)!
    }
    
    @IBAction func logOut() {
        if user != User.currentUser {
            return
        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("Cancel")
        }
        
        actionSheetController.addAction(cancelActionButton)
        
        let logOutActionButton = UIAlertAction(title: "Log Out", style: .Destructive) { (action) in
            TwitterClient.sharedInstance.logout()
        }
        
        actionSheetController.addAction(logOutActionButton)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }

}
