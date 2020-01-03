//
//  TweetViewController.swift
//  Twitter
//
//  Created by Kavya Sahai on 2/28/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweettextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tweettextView: UITextView!
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
     @IBAction func tweet(_ sender: Any) {
        if(!tweettextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweettextView.text, success: {self.dismiss(animated: true, completion: nil)}, failure: { (error) in
                print("Error posting tweer \(error)")
                self.dismiss(animated: true, completion: nil)
            })
            
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
