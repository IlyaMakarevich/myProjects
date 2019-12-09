//
//  StackPresentationNextVC.swift
//  Telegram_task1_code
//
//  Created by MacBook Pro  on 09.12.2019.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class StackPresentationNextVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    @objc func goBack() {
    }
    
    func setupVC() {
        view.backgroundColor = .green
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Stack Presentation VC"
    }

}
