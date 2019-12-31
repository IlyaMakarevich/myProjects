//
//  TimeLineViewController.swift
//  twitter2
//
//  Created by MacBook Pro  on 31.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  
    @IBOutlet weak var timeLineTableView: UITableView!
    
    var tweetArray = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineTableView.delegate = self
        timeLineTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TwitterTableViewCell
        cell.nameLabel.text = "User Name"
        cell.tweetLabel.text = "Woody equal ask saw sir weeks aware decay. Entrance prospect removing we packages strictly is no smallest he. For hopes may chief get hours day rooms. Oh no turned behind polite piqued enough at. Forbade few through inquiry blushes you. Cousin no itself eldest it in dinner latter missed no. Boisterous estimating interested collecting get conviction friendship say boy. Him mrs shy article smiling respect opinion excited. Welcomed humoured rejoiced peculiar to in an. "
        return cell
    }


    
    


    
    


}