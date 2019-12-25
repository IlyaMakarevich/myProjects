//
//  HomeViewController.swift
//  TwitterTest
//
//  Created by Константин on 22.03.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, TwitterTableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lastTweetId: Int?
    
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
        
        TwitterClient.sharedInstance.homeTimeline(lastTweetId, success: { (tweets) in
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
    
    func openProfile(userScreenname: NSString) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewNavigationController") as! UINavigationController
        let pVc = vc.viewControllers.first as! ProfileViewController
        pVc.userScreenname = userScreenname
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}
