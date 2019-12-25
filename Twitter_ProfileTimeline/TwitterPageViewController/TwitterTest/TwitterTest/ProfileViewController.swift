//
//  ProfileViewController.swift
//  TwitterTest
//
//  Created by Константин on 05.04.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TwitterTableViewDelegate {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageSuperview: UIView!
    
    @IBOutlet weak var shadowEffectView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closeModalButton: UIButton!
    
    @IBOutlet weak var profileDescriptionContainer: UIView!

    var lastTweetId: Int?
    
    var user: User!
    var userScreenname: NSString?
    
    var tweets: [Tweet]? {
        didSet {
            lastTweetId = tweets![tweets!.endIndex - 1].tweetID as Int
        }
    }
    
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading = false
    var loadingMoreView: InfinityScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName("ProfileConfigureView", object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            self.configureViewController()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if userScreenname == nil {
            user = User.currentUser!
            configureViewController()
        } else {
            //populate User by screenname via api
        }
    }
    
    func configureViewController() {
        let profileImageUrl = user.profileUrl
        let backgorundImageUrl = user.backgroundImageURL
        
        profileImageView.setImageWithURL(profileImageUrl!)
        if let backgorundImageUrl = backgorundImageUrl {
            backgroundImageView.setImageWithURL(NSURL(string: backgorundImageUrl)!)
            if user.usingBannerImage != true {
                backgroundImageView.contentMode = .ScaleAspectFill
            } else {
                backgroundImageView.contentMode = .Redraw
            }
        }
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 5
        profileImageSuperview.layer.cornerRadius = 5
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = shadowEffectView.bounds
        let topColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor as CGColorRef
        let bottomColor = UIColor(white: 0, alpha: 0.0).CGColor as CGColorRef
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        self.shadowEffectView.layer.addSublayer(gradientLayer)
        
        if (user.screenname != User.currentUser?.screenname) {
            let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.closeProfileModal))
            closeModalButton.userInteractionEnabled = true
            closeModalButton.addGestureRecognizer(tap)
            closeModalButton.hidden = false
        } else {
            closeModalButton.hidden = true
        }
        
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        let logo  = UIImage(named: "Icon-Twitter")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
        reloadData()
        
        //Set up pull to refresh loading indicator
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.reloadData), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        //Set up Infinity Scroll loading indicator
        let frame =  CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfinityScrollActivityView.defaultHeight)
        loadingMoreView = InfinityScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        var insets = tableView.contentInset
        insets.bottom += InfinityScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tweets == nil) {
            return 0
        } else {
            return tweets!.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! TweetCompactCell
        cell.indexPath = indexPath
        cell.tweet = tweets![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    var reloadedIndexPaths = [Int]()
    
    func reloadTableCellAtIndex(cell: UITableViewCell, indexPath: NSIndexPath) {
        if(reloadedIndexPaths.indexOf(indexPath.row) == nil) {
            reloadedIndexPaths.append(indexPath.row)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }
    }
    
    func reloadData(append: Bool = false) {
        
        TwitterClient.sharedInstance.userTimeline(user, maxId: lastTweetId, success: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
            if (append) {
                var cleaned = tweets
                if tweets.count > 0 {
                    cleaned.removeAtIndex(0)
                }
                
                if cleaned.count > 0 {
                    self.tweets?.appendContentsOf(cleaned)
                    self.isMoreDataLoading = false
                    self.loadingMoreView?.stopAnimation()
                    self.tableView.reloadData()
                }
            } else {
                self.lastTweetId = nil
            }

            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading && tweets?.count > 0) {
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging {
                isMoreDataLoading = true
                reloadData(true)
            }
        }
    }
    
    func closeProfileModal() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
