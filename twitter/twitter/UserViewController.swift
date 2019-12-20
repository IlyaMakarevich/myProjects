//
//  LoginViewController.swift
//  twitter
//
//  Created by MacBook Pro  on 19.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    let loginBarButtonItem = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginUser))
    
    private let floatinButton: UIButton = {
        let floatingButton = UIButton()
        floatingButton.frame = CGRect(x: 285, y: 485, width: 70, height: 70)
        floatingButton.setTitle("+", for: .normal)
        floatingButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        floatingButton.clipsToBounds = true
        floatingButton.layer.cornerRadius = 50
        floatingButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        floatingButton.layer.borderWidth = 3.0
        floatingButton.addTarget(self,action: #selector(newPost), for: .touchUpInside)
        return floatingButton
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC() {
        view.backgroundColor = UIColor(red: 225/255, green: 232/255, blue: 237/255, alpha: 1.0)
       navigationItem.title = "Home"
       navigationItem.rightBarButtonItem  = loginBarButtonItem
        view.addSubview(floatinButton)
    }
    
    @objc func loginUser() {
        print("login....")
    }
    
    @objc func newPost() {
        print("new post....")
    }

}
