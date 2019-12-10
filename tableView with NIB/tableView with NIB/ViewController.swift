//
//  ViewController.swift
//  tableView with NIB
//
//  Created by MacBook Pro  on 09.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "LineCell", bundle: nil)
        let tableNibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        tableView.register(nib, forCellReuseIdentifier: "LineCell")
        tableView.rowHeight = UITableView.automaticDimension
        self.view.addSubview(tableNibView)
    }


}

