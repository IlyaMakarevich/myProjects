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
        setupView()
    }



    private func setupView() {
        view.backgroundColor = .gray
        view.addSubview(nestedView)
        NSLayoutConstraint.activate([
            nestedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nestedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nestedView.topAnchor.constraint(equalTo: view.topAnchor),
            nestedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

