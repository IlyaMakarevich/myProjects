//
//  MainTabBarController.swift
//  UIKitNavigation
//
//  Created by Ruslan Sabirov on 05.12.2019.
//  Copyright © 2019 Ruslan Sabirov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let maxNumberOfTabs = 8
    private let numberOfVCTypes = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarControllers()
        
    }
    
    func createTabBarControllers() {
        let randomNumber = Int.random(maxNumberOfTabs)
        for _ in 0...randomNumber + 1 {
            switch (Int.random(numberOfVCTypes)) {
            case 0:
                guard let modalImage = UIImage(named: "modal") else {return}
                let navController = createNavController(vc: ModalPresentationVC(), title: "ModalVC", image: modalImage)
                addChild(navController)
            case 1:
            guard let stackImage = UIImage(named: "stack") else {return}
                let navController = createNavController(vc: StackPresentationVC(), title: "StackVC", image: stackImage)
                addChild(navController)
            default:
                return
            }

        }
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

extension Int {
   static func random(_ upperBound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upperBound)))
    }
}
