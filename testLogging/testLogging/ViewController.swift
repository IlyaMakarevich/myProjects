//
//  ViewController.swift
//  testLogging
//
//  Created by Ilya Makarevich on 2/21/20.
//  Copyright © 2020 apalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User(username: "John the Tester", password: "qwerty", email: "john@example.com")
        user.printInfo()
    }
}

let logger: Logger? = {
    #if DEBUG
    return Logger()
    #else
    return nil
    #endif
}()

struct User {
    var username: String
    var password: String
    var email: String

    func printInfo() {
        logger?.log(category: .app, message: "Username: \(username), password: \(password), email: \(email)")
    }
}

