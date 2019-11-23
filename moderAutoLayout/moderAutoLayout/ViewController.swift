//
//  ViewController.swift
//  moderAutoLayout
//
//  Created by Ilya Makarevich on 11/19/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }


    @IBOutlet weak var greenView: UIView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let radius = greenView.bounds.width / 20
        greenView.layer.cornerRadius = radius
    }
}

