//
//  ProfileViewController.swift
//  twitter2
//
//  Created by MacBook Pro  on 22.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire


class ProfileViewController: UIViewController {


    @IBOutlet var loginButton: UIButton!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var folowersButton: UIButton!
    
    var oauthSwift: OAuth1Swift?
    var handle: OAuthSwiftRequestHandle?
    var credentials: OAuthSwiftCredential?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }


    @IBAction func getInfoTapped(_ sender: Any) {
        request("https://api.twitter.com/1.1/account/verify_credentials.json", method: .get, parameters: nil).validate().responseJSON { response in
            debugPrint(response)
        }
    }
    
    @IBAction func followersTapped(_ sender: Any) {
        
        let headers = ["authorization" : "c"]
        request("https://api.twitter.com/1.1/followers/ids.json?screen_name=twitterdev", method: .get, parameters: nil, headers: headers).responseJSON {
            response in
            debugPrint(response)
        }
        
    }
    @IBAction func signInTapped(_ sender: Any) {
        print("login button tapped")
        testTwitter()
    }

    @IBAction func profileTapped(_ sender: UIBarButtonItem) {

        print("oauthToken = \(credentials?.oauthToken)")
        print("oauthTokenSecret = \(credentials?.oauthTokenSecret)")
        // create the alert
        let alertController = UIAlertController(title: "Log out", message: "Clear token?", preferredStyle: .alert)

        let clearAction = UIAlertAction(title: "Clear token", style: UIAlertAction.Style.default) {
              UIAlertAction in
            UserDefaults.standard.removeObject(forKey: "oauthToken")
            UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")

            _ = self.checkAccessToken()
            self.updateLabels()
          }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                 UIAlertAction in
                 NSLog("Cancel Pressed")
             }
        alertController.addAction(clearAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateLabels() {
        loginButton.isEnabled = !checkAccessToken() ? true : false
        profileButton.isEnabled = checkAccessToken() ? true : false
        infoButton.isEnabled = checkAccessToken() ? true : false
        folowersButton.isEnabled = checkAccessToken() ? true : false
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
                print(parameters["user_id"])
                self.saveAccessToken(data: credential)
                self.updateLabels()
            // Do your request
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    


    func saveAccessToken(data: OAuthSwiftCredential ) {
        credentials = data
        UserDefaults.standard.set(data.oauthToken, forKey: "oauthToken")
        UserDefaults.standard.set(data.oauthTokenSecret, forKey: "oauthTokenSecret")
    }

    func checkAccessToken() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: "oauthToken") {
            print("token already in UserDefaults")
            return true
        } else {
            return false
        }
    }
}

enum JSONError: Error {
    case parsing(String)
}
