//
//  ViewController.swift
//  twitter
//
//  Created by MacBook Pro  on 19.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    func setupTabBarController() {
        view.backgroundColor = UIColor(red: 225/255, green: 232/255, blue: 237/255, alpha: 1.0)
        guard let homeImage = UIImage(named: "home") else {return}
        let userViewController = createNavController(vc: UserViewController(), title: "", image: homeImage)
        
        guard let newsImage = UIImage(named: "news") else {return}
        let scrollViewController = createNavController(vc: ScrollViewController(), title: "", image: newsImage)
        
        addChild(userViewController)
        addChild(scrollViewController)
    }


}

extension UIViewController {
    func createNavController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
