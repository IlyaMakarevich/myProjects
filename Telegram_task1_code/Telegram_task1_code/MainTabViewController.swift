//
//  MainTabViewController.swift
//  Telegram_task1_code
//
//  Created by Ilya Makarevich on 12/8/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    

    func setupTabBarController() {
        view.backgroundColor = .green
        guard let modalImage = UIImage(named: "modal") else {return}
        let viewController1 = createNavController(vc: ModalPresentationVC(), title: "Modal", image:modalImage)

        guard let stackImage = UIImage(named: "stack") else {return}
        let viewController2 = createNavController(vc: StackPresentationVC(), title: "Stack", image:stackImage)

        addChild(viewController1)
        addChild(viewController2)
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
