//
//  ViewController.swift
//  animateView
//
//  Created by Ilya Makarevich on 12/1/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let redView: UIView = {
        let view = UIView()
        view.frame  = CGRect(x: 50, y: 50, width: 50, height: 50)
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    private func setupView() {
        view.addSubview(redView)
    }




}

