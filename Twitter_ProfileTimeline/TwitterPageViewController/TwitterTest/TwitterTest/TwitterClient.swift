//
//  TwitterClient.swift
//  TwitterTest
//
//  Created by Константин on 22.03.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    //OAuth = Fetch Request Token + Redirect to Auth + Fetch Access Token + Callback URL
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "kAxM1UPAQql4QXW503W9xOqer", consumerSecret: "j3p67CGGBIgUJA550uFaOm4vRXu90D5uEEGQjhFAVgxmiZOBGI")
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    weak var delegate: TwitterLoginDelegate?
    
    //Getting request token to open up auth link in safari
    func login(success: ()->(), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twittertest://oauth")!, scope: nil, success: { (requestToken) in
            print("Got token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authenticate?oauth_token=" + requestToken.token)!
            
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    //Get access token and save user
    func  handleOpenUrl(url: NSURL) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.splashDelay = true
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)!
        
        //Getting access token
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken) in
            self.currentAccount({ (user: User) in
                //Calling setter and saving user
                User.currentUser = user
                self.loginSuccess?()
                self.delegate?.continueLogin()
                }, failure: { (error) in
                    self.loginFailure?(error)
            })
            self.loginSuccess?()
        }) { (error) in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    //Get the current account
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            success(user)
        }) { (task, error) in
            print("error: \(error.localizedDescription)")
            failure(error)
        }
    }
    
    //Gets the home timeline of the current user
    func homeTimeline(maxId: Int? = nil, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        var params = ["count": 10]
        if (maxId != nil) {
            params["max_id"] = maxId
        }
        
        GET("1.1/statuses/home_timeline.json", parameters: params, progress: nil, success: { (task, response) in
            //print(response)
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
        }) { (task, error) in
            failure(error)
        }
    }
    
    //Gets the user timeline of the current user
    func userTimeline(user: User, maxId: Int? = nil, success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        var params = ["count": 10]
        params["user_id"] = user.id!
        if (maxId != nil) {
            params["max_id"] = maxId
        }
        
        GET("1.1/statuses/user_timeline.json", parameters: params, progress: nil, success: { (task, response) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            }) { (task, error) in
                failure(error)
        }
    }
    
    //Logout
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    //Retweets (Unretweets) a status (specified by the tweetID) that isn't owned by the User
    func retweet(params: NSDictionary?, retweet: Bool, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        let tweetId = params!["id"] as! Int
        let endpoint = retweet ? "retweet" : "unretweet"
        POST("1.1/statuses/\(endpoint)/\(tweetId).json", parameters: params, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            completion(tweet: tweet, error: nil)
            }) { (task, error) in
                completion(tweet: nil, error: error)
        }
    }
    
    //Favorites (Unfavorites) a status (specified by the tweetID) that isn't owned by the User
    func favorite(params: NSDictionary?, favorite: Bool, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        let endpoint = favorite ? "create" : "destroy"
        POST("1.1/favorites/\(endpoint).json", parameters: params, progress: nil, success: { (task, response) in
            let tweet = Tweet(dictionary: response as! NSDictionary)
            completion(tweet: tweet, error: nil)
        }) { (task, error) in
            completion(tweet: nil, error: error)
        }
    }
}
