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


class HomeViewController: UIViewController {


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var folowersButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var getInfoButton: UIButton!
    @IBOutlet weak var getRelations: UIButton!
    
    var accountName: String = ""

    var oauthSwift = OAuth1Swift(
        consumerKey:    Keys.twitterConsumerKey,
        consumerSecret: Keys.twitterSecretKey,
        requestTokenUrl: "https://api.twitter.com/oauth/request_token",
        authorizeUrl:    "https://api.twitter.com/oauth/authorize",
        accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
    )

    var handle: OAuthSwiftRequestHandle?
    var credentials: OAuthSwiftCredential?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }

    @IBAction func getInfoTapped(_ sender: Any) {
        handle = oauthSwift.client.get("https://api.twitter.com/1.1/account/verify_credentials.json") { results in
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func getRelationsTapped(_ sender: Any) {
        print("getting relations")
       
        self.oauthSwift.client.get("https://api.twitter.com/1.1/friendships/lookup.json", parameters: ["screen_name": accountName] ) { results in
            
         switch results {
         case .success(let response):
           let jsonDict = try? response.jsonObject()
           print(String(describing: jsonDict))
         case .failure(let error):
           print(error)
         }
        }
    }
    @IBAction func followersTapped(_ sender: Any) {
        self.oauthSwift.client.get("https://api.twitter.com/1.1/followers/ids.json",  parameters: ["screen_name": accountName]) { results in

         switch results {
         case .success(let response):
           let jsonDict = try? response.jsonObject()
           print(String(describing: jsonDict))
         case .failure(let error):
           print(error)
         }

        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        print("login button tapped")
        oauthTwitter()
        
       
    }
    
 

    @IBAction func profileTapped(_ sender: UIBarButtonItem) {
        checkAccessToken()

        print("oauthToken = \(credentials?.oauthToken)")
        print("oauthTokenSecret = \(credentials?.oauthTokenSecret)")

        // create the alert
        let alertController = UIAlertController(title: "Log out", message: "Clear token from userdefaults?", preferredStyle: .alert)

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

        alertController.addAction(cancelAction)
        alertController.addAction(clearAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func getTimelineTapped(_ sender: Any) {
        handle = oauthSwift.client.get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterapi&count=2") { results in
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }

        }
        
    }
    func updateLabels() {
        loginButton.isEnabled = !checkAccessToken() ? true : false
        profileButton.isEnabled = checkAccessToken() ? true : false
        getInfoButton.isEnabled = checkAccessToken() ? true : false
        folowersButton.isEnabled = checkAccessToken() ? true : false
        idLabel.isHidden = !checkAccessToken() ? true : false
    }

    func oauthTwitter() {
        oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthSwift)
        handle = oauthSwift.authorize(
        withCallbackURL: URL(string: "twitter2://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                print(parameters["user_id"])
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                self.saveAccessToken(data: credential)
                self.updateLabels()
                self.idLabel.text = String(format:"Connected to : %@", parameters["screen_name"] as! CVarArg)

                self.accountName = parameters["screen_name"] as! String
                
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
