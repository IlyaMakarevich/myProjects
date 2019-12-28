//
//  APIManager.swift
//  twitter2
//
//  Created by MacBook Pro  on 27.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import Foundation
import Alamofire
import OAuthSwift
import KeychainAccess

class APIManager: SessionManager{
    
    static var shared: APIManager = APIManager()
    var oauthManager : OAuth1Swift!
    var handle: OAuthSwiftRequestHandle?
    var credentials = OAuthSwiftCredential(consumerKey: Keys.twitterConsumerKey, consumerSecret: Keys.twitterSecretKey)
    var user = User(name: "")
    let defaults = UserDefaults.standard
    let homeVC = HomeViewController()
    
    private init () {
        super.init()
        //create instance
        oauthManager = OAuth1Swift(
               consumerKey:    Keys.twitterConsumerKey,
               consumerSecret: Keys.twitterSecretKey,
               requestTokenUrl: "https://api.twitter.com/oauth/request_token",
               authorizeUrl:    "https://api.twitter.com/oauth/authorize",
               accessTokenUrl:  "https://api.twitter.com/oauth/access_token"
           )
        
        // Retrieve access token from keychain if it exists
            if let credential = retrieveCredentials() {
                oauthManager.client.credential.oauthToken = credential.oauthToken
                print(credential.oauthToken)
                oauthManager.client.credential.oauthTokenSecret = credential.oauthTokenSecret
                print(credential.oauthTokenSecret)
            }
        
        if let user = defaults.string(forKey: "screen_name") {
            self.user.name = user
        }
    }
   
    
    //Twitter api methods
    func login(success: @escaping () -> (), failure: @escaping (Error?) -> ()) {
        //oauthSwift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthSwift)
        handle = oauthManager.authorize(
        withCallbackURL: URL(string: "twitter2://oauth-callback/twitter")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                self.saveCredenitalsInKeychain(credential: credential)
                self.defaults.set(parameters["screen_name"] as! String, forKey: "screen_name")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func verifyCredentials() {
        handle = oauthManager.client.get("https://api.twitter.com/1.1/account/verify_credentials.json") { results in
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRelations(){
        print("getting relations")
        
        handle = oauthManager.client.get("https://api.twitter.com/1.1/friendships/lookup.json", parameters: ["screen_name": user.name] ) { results in
            
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showFollowers() {
        handle = oauthManager.client.get("https://api.twitter.com/1.1/followers/ids.json",  parameters: ["screen_name": user.name]) { results in
            
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func getTimeline() {
        handle = oauthManager.client.get("https://api.twitter.com/1.1/statuses/user_timeline.json", parameters: ["screen_name": user.name]) { results in
            switch results {
            case .success(let response):
                let jsonDict = try? response.jsonObject()
                print(String(describing: jsonDict))
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func logOut(success: @escaping () -> (), failure: @escaping (Error?) -> ()) {
        checkAccessToken()
        // create the alert
        let alertController = UIAlertController(title: "Log out", message: "Clear token from userdefaults?", preferredStyle: .alert)

        let clearAction = UIAlertAction(title: "Clear token", style: UIAlertAction.Style.default) {
              UIAlertAction in
            self.clearCredentials()
            self.checkAccessToken()
          }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                 UIAlertAction in
                 NSLog("Cancel Pressed")
             }

        alertController.addAction(cancelAction)
        alertController.addAction(clearAction)

        topMostController().present(alertController, animated: true, completion: nil)
    }

    
    // MARK: Save Tokens in Keychain
    func saveCredenitalsInKeychain(credential: OAuthSwiftCredential) {
        let keychain = Keychain()
        let data = NSKeyedArchiver.archivedData(withRootObject: credential)
        keychain[data: "twitter_credentials"] = data
    }
    
    
    // MARK: Retrieve Credentials
    func retrieveCredentials() -> OAuthSwiftCredential? {
        let keychain = Keychain()
        if let data = keychain[data: "twitter_credentials"] {
            credentials = NSKeyedUnarchiver.unarchiveObject(with: data) as! OAuthSwiftCredential
            return credentials
        } else {
            return nil
        }
    }
    
    // MARK: Clear tokens in Keychain
    func clearCredentials() {
        // Store access token in keychain
        let keychain = Keychain()
        do {
            try keychain.remove("twitter_credentials")
        } catch let error {
            print("error: \(error)")
        }
    }
    
    func checkAccessToken() -> Bool {
        let keychain = Keychain()
        if let data = keychain[data: "twitter_credentials"] {
            return true
        } else {
            return false
        }
    }
    
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}
