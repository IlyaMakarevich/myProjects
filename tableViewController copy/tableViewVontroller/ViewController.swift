//
//  ViewController.swift
//  tableViewVontroller
//
//  Created by MacBook Pro  on 11.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableViewController = UITableViewController(style:.plain)
    var refresh = UIRefreshControl()
    
    var allTimeItems = [Date]()
    var cellIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        self.refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        view.addSubview(tableViewController.tableView)
        tableViewController.tableView.addSubview(refresh)
    }
    
    @objc func handleRefresh() {
        allTimeItems.append(Date())
        refresh.endRefreshing()
        let indexPathNewRow = IndexPath(row: allTimeItems.count - 1, section: 0)
        tableViewController.tableView.insertRows(at: [indexPathNewRow], with: .automatic)

    }
    func createTableView() {
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTimeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let date = allTimeItems[indexPath.row]
        cell.textLabel?.text = ("\(date)")
        return cell
    }
    
    
}
