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
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        return button
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupFloatingButton()
    }
    
    func setupVC() {
        view.backgroundColor = UIColor(red: 225/255, green: 232/255, blue: 237/255, alpha: 1.0)
       navigationItem.title = "Home"
       navigationItem.rightBarButtonItem = loginBarButtonItem
    }
    
    func setupFloatingButton() {
        view.addSubview(floatinButton)
        guard let postImage = UIImage(named: "pencil-2") else {return}
        floatinButton.setImage(postImage, for: .normal)
        floatinButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            floatinButton.widthAnchor.constraint(equalToConstant: 50),
            floatinButton.heightAnchor.constraint(equalToConstant: 50),
            view.trailingAnchor.constraint(equalTo: floatinButton.trailingAnchor, constant: 30),
            view.bottomAnchor.constraint(equalTo: floatinButton.bottomAnchor, constant: 80)])
        
        floatinButton.layer.cornerRadius = 25
        floatinButton.clipsToBounds = true
        floatinButton.setNeedsLayout()
        floatinButton.layoutIfNeeded()
    }
    
    @objc func loginUser() {
        print("login....")
    }
    
    @objc func newPost() {
        print("new post....")
    }

}
