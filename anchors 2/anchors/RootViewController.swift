//
//  RootViewController.swift
//  anchors
//
//  Created by Ilya Makarevich on 11/22/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private let nestedView: NestedView = {
        let view = NestedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
    }
    
    override func viewWillLayoutSubviews() {
        setupView()
    }



    private func setupView() {
        view.backgroundColor = .gray
        view.addSubview(nestedView)
        nestedView.backgroundColor = .green
        NSLayoutConstraint.activate([
            nestedView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50.0),
            view.trailingAnchor.constraint(equalTo: nestedView.trailingAnchor, constant: 50.0),
            nestedView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0),
            nestedView.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 0.25)
        ])
    }


}

