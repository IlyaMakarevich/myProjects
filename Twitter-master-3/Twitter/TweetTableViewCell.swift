//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Kavya Sahai on 2/21/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var favourited:Bool = false
    var tweetId:Int = -1
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error retweeting: \(Error)")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    
    @IBAction func fav(_ sender: Any) {
        let toBeFav = !favourited
        if(toBeFav){
            TwitterAPICaller.client?.favouriteTweet(tweetId: tweetId, success: {
                self.setFavourite(true)
            }, failure: { (Error) in
                print("Error favoriting: \(Error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavouriteTweet(tweetId: tweetId, success:{ self.setFavourite(false)}, failure: { (Error) in
                print("Error unfavoriting: \(Error)")
            })
        }
    }
    
    func setFavourite(_ isFavourited:Bool){
        favourited = isFavourited
        if(favourited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else{
             favButton.setImage(UIImage(named:"favor-icon-1"), for: UIControl.State.normal)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
