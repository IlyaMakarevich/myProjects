//
//  ViewController.swift
//  cratingCustomView
//
//  Created by Ilya Makarevich on 11/20/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let rgbView = RGBView(frame: view.bounds)
        rgbView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(rgbView)
    }


}

