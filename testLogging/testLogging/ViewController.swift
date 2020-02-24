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

        //1.
        user.log1()

        //2.
        user.log2(message: "message")
        user.log2Release(message: "release message")

        //3.
#if DEBUG
        user.log3()
#endif
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

    func log1() {
        logger?.log(category: .app, message: "\n<<<FIRST LOG>>> Username: \(username), password: \(password), email: \(email)")
    }


    func log2(message: String = "", _ path: String = #file, _ function: String = #function) {
        if (isDebug) {
            guard let file = path.components(separatedBy: "/").last?.components(separatedBy: ".").first else { return }
            NSLog("\n<<<SECOND LOG>>> \(file).\(function): \(message)")
        }
    }

    func log2Release(message: String = "", _ path: String = #file, _ function: String = #function) {
        if (!isDebug){
        guard let file = path.components(separatedBy: "/").last?.components(separatedBy: ".").first else { return }
        NSLog("\n<<<SECOND RELEASE LOG>>> \(file).\(function): \(message)")
        }

    }

    func log3() {
        print("\n<<<THIRD LOG>>>   ")
    }

}



let isDebug: Bool = {
    var isDebug = false
    // function with a side effect and Bool return value that we can pass into assert()
    func set(debug: Bool) -> Bool {
        isDebug = debug
        return isDebug
    }
    // assert:
    // "Condition is only evaluated in playgrounds and -Onone builds."
    // so isDebug is never changed to true in Release builds
    assert(set(debug: true))
    return isDebug
}()






