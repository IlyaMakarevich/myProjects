//
//  ScrollViewController.swift
//  twitter
//
//  Created by MacBook Pro  on 19.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "News Screen"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News feed will be here"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
