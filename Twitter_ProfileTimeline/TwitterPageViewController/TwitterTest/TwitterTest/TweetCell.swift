//
//  TweetCell.swift
//  TwitterTest
//
//  Created by Константин on 29.03.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var authorScreennameLabel: UILabel!
    
    @IBOutlet var tweetContentsLabel: UILabel!
    @IBOutlet var tweetAgeLabel: UILabel!
    
    @IBOutlet var retweetCountLabel: UILabel!
    @IBOutlet var favoriteCountLabel: UILabel!
    @IBOutlet var favoriteButton: DOFavoriteButton!
    @IBOutlet var retweetButton: DOFavoriteButton!
    
    @IBOutlet var mediaImageView: UIImageView!
    @IBOutlet var mediaImageVerticalSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var mediaImageHeightConstraint: NSLayoutConstraint!
    
    var tweetID: NSNumber?
    
    var indexPath: NSIndexPath!
    
    weak var delegate: TwitterTableViewDelegate?
    
    var tweetTextFontSize: CGFloat { get { return 15.0 } }
    var tweetTextFontWeight: CGFloat { get { return UIFontWeightRegular } }
    
    var tweet: Tweet! {
        didSet {
            tweetSetConfigureSubviews()
        }
    }
    
    func tweetSetConfigureSubviews() {
        tweetID = tweet.tweetID

        profilePictureImageView.setImageWithURL(tweet.authorProfilePicURL!)
        profilePictureImageView.layer.cornerRadius = 5
        profilePictureImageView.clipsToBounds = true
        authorNameLabel.text = tweet.author as? String
        authorScreennameLabel.text = "@" + (tweet.screenname as! String)
        
        tweetContentsLabel.text = tweet.text as? String
        
        let urls = tweet.urls
        let media = tweet.media
        
        retweetButton.selected = tweet.retweeted
        favoriteButton.selected = tweet.favorited
        
        mediaImageView.image = nil
        
        var displayUrls = [String]()
        
        if let urls = urls {
            for url in urls {
                let urltext = url["url"] as! String
                tweetContentsLabel.text = tweetContentsLabel.text?.replace(urltext, withString: "")
                
                var displayurl = url["display_url"] as! String
                if let expandedURL = url["expanded_url"] {
                    displayurl = expandedURL as! String
                }
                displayUrls.append(displayurl)
            }
        }
        
        if let media = media {
            for medium in media {
                let urltext = medium["url"] as! String
                tweetContentsLabel.text = tweetContentsLabel.text?.replace(urltext, withString: "")
                if((medium["type"] as? String) == "photo") {
                    
                    mediaImageVerticalSpacingConstraint.constant = 8
                    mediaImageView.hidden = false
                    
                    let mediaurl = medium["media_url_https"] as! String
                    mediaImageHeightConstraint.active = false
                    
                    mediaImageView.layer.cornerRadius = 5
                    mediaImageView.clipsToBounds = true;
                    mediaImageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: mediaurl)!), placeholderImage: nil, success: { (request, response, image) -> Void in
                        // success
                        self.mediaImageView.image = image
                        self.delegate?.reloadTableCellAtIndex(self, indexPath: self.indexPath)
                        }, failure: { (request, response, error) -> Void in
                            // error
                    });
                }
            }
        }
        
        if(displayUrls.count > 0){
            let content = tweetContentsLabel.text ?? ""
            
            let urlText = " " + displayUrls.joinWithSeparator(" ")
            
            let text = NSMutableAttributedString(string: content)
            
            text.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(tweetTextFontSize, weight: tweetTextFontWeight), range: NSRange(location: 0, length: content.characters.count))
            
            let links = NSMutableAttributedString(string: urlText)
            links.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(tweetTextFontSize, weight: tweetTextFontWeight), range: NSRange(location: 0, length: urlText.characters.count))
            
            links.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 36/255.0, green: 144/255.0, blue: 212/255.0, alpha: 1), range: NSRange(location: 0, length: urlText.characters.count))
            
            text.appendAttributedString(links)
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            style.lineBreakMode = .ByCharWrapping
            text.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: text.string.characters.count))
            
            tweetContentsLabel.attributedText = text
        }
    }
    
    
    @IBAction func onRetweetButton(sender: DOFavoriteButton) {
        if(sender.selected) {
            // deselect
            sender.deselect()
            tweet.retweeted = false
            retweetCountLabel.text = String(tweet.retweetsCount) ?? ""
        } else {
            // select with animation
            sender.select();
            tweet.retweeted = true;
            retweetCountLabel.text = String(tweet.retweetsCount) ?? ""
        }
    }
    
    @IBAction func onFavoriteButton(sender: DOFavoriteButton) {
        if(sender.selected) {
            // deselect
            sender.deselect()
            tweet.favorited = false
            favoriteCountLabel.text = String(tweet.favoritesCount) ?? ""
        } else {
            // select with animation
            sender.select()
            tweet.favorited = true
            favoriteCountLabel.text = String(tweet.favoritesCount) ?? ""
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
