//
//  SplashViewController.swift
//  TwitterTest
//
//  Created by Константин on 21.03.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, TwitterLoginDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!appDelegate.splashDelay) {
            delay(1.0, closure: {
                self.continueLogin()
            })
        }
        
    }
    
    func goToLogin() {
        self.performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
    func goToApp() {
        self.performSegueWithIdentifier("HomeSegue", sender: self)
    }
    
    func continueLogin() {
        appDelegate.splashDelay = false
        if User.currentUser == nil {
            self.goToLogin()
        } else {
            self.goToApp()
        }
    }
    
}
