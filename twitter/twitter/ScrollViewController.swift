//
//  ScrollViewController.swift
//  twitter
//
//  Created by MacBook Pro  on 19.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import Alamofire

class ScrollViewController: UIViewController {
    
    let label = UILabel()
    var posts: [Post] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        myFirstRequest()
    }
    
    func setupVC() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "News Screen"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News feed will be here"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func myFirstRequest() {
        

        
        request("http://jsonplaceholder.typicode.com/posts", method: .get).validate().responseJSON { responseJSON  in
            guard let statusCode = responseJSON.response?.statusCode else {return}
            print("status code: ", statusCode)
            switch responseJSON.result {
            case .success(let value):
                print("value", value)
                guard let posts = Post.getArray(from: value) else {return}
                print(posts)
                self.label.text = ("First id = \(String(posts[0].id))")
            case .failure(let error):
                print(error)
            }
            
        }
        print("viewDidLoad ended")
    }
}
