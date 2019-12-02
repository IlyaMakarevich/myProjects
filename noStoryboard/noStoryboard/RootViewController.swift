//
//  RootViewController.swift
//  noStoryboard
//
//  Created by Ilya Makarevich on 11/19/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    let padding: CGFloat = 50.0

    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }

    override func viewWillLayoutSubviews() {
        if greenView.superview == nil {
            view.addSubview(greenView)
            let width = view.bounds.width - 2*padding
            greenView.frame = CGRect(x: padding, y: padding, width: width, height: 3*padding)
        }
    }



}
