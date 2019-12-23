//
//  ProfileViewController.swift
//  twitter2
//
//  Created by MacBook Pro  on 22.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import Alamofire
import SafariServices


class ProfileViewController: OAuthViewController {
    
   
//    let oauthswift = OAuth1Swift(
//        consumerKey:    Keys.twitterConsumerKey,
//        consumerSecret: Keys.twitterSecretKey,
//        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
//        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
//        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
//    )

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        print("login button tapped")
        
        
        
        
        
        
        
        
//        let handle = oauthswift.authorize(
//            withCallbackURL: URL(string: "twitter2://")!) { result in
//            switch result {
//            case .success(let (credential, response, parameters)):
//              print(credential.oauthToken)
//              print(credential.oauthTokenSecret)
//              print(response)
//              // Do your request
//            case .failure(let error):
//              print(error.localizedDescription)
//            }
//        }
        
    }
    
    
    

    
    
}
