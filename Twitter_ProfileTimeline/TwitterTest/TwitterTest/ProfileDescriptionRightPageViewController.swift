//
//  ProfileDescriptionRightPageViewController.swift
//  TwitterTest
//
//  Created by Константин on 07.04.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class ProfileDescriptionRightPageViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName("ProfileConfigureRightSubviews", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            if User.tempUser != nil {
                self.descriptionLabel.text = User.tempUser?.tagline as? String
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if User.tempUser != nil {
            self.descriptionLabel.text = User.tempUser?.tagline as? String
        }
    }

}
