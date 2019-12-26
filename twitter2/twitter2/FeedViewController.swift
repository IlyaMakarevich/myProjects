//
//  FeedViewController.swift
//  twitter2
//
//  Created by MacBook Pro  on 26.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let oauthswift = OAuth1Swift(consumerKey: Keys.twitterConsumerKey, consumerSecret: Keys.twitterSecretKey)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadTimeline()
    }
    
func loadTimeline() {
    
    let timelineURL = "https://api.twitter.com/1.1/statuses/user_timeline.json"
    request(timelineURL, method: .get).responseJSON { (myResponse) in
        switch myResponse.result {
        case .success:
            break
        case .failure:
            break
    }
    }
}
        
public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
}

public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    return cell
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}
