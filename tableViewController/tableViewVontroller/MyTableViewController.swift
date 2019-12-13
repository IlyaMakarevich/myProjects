//
//  MyTableViewController.swift
//  tableViewVontroller
//
//  Created by MacBook Pro  on 11.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    var itemArry = [Model]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = Model(name:"Ilya Makarevich", prof:"ios developer")
        itemArry.append(item)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell {
            let item = itemArry[indexPath.row]
            cell.refresh(item)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
}
