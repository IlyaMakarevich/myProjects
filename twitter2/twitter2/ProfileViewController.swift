//
//  ProfileViewController.swift
//  twitter2
//
//  Created by MacBook Pro  on 22.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import OAuthSwift


class ProfileViewController: UIViewController {


    @IBOutlet var loginLabel: UIButton!

    var oauthSwift: OAuth1Swift?
    var handle: OAuthSwiftRequestHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.isEnabled = true
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        print("login button tapped")
        testTwitter()
    }

    func testTwitter() {
        oauthSwift = OAuth1Swift(
            consumerKey:    Keys.twitterConsumerKey,
            consumerSecret: Keys.twitterSecretKey,
            requestTokenUrl: "https://api.twitter.com/oauth/request_token",
            authorizeUrl:    "https://api.twitter.com/oauth/authorize",
            accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
        )
        // authorize
        handle = oauthSwift?.authorize(
            withCallbackURL: URL(string: "twitter2://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print(credential.oauthToken)
              print(credential.oauthTokenSecret)
              print(parameters["user_id"])
              print(response)
              self.loginLabel.isEnabled = false
              // Do your request
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
}

}

