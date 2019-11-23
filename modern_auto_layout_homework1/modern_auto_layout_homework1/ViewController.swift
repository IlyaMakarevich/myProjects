//
//  ViewController.swift
//  modern_auto_layout_homework1
//
//  Created by Ilya Makarevich on 11/20/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var paddingGreen: CGFloat = 50.0
    private let greenView: UIView = {
              let view = UIView()
              view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
              return view
          }()

          private let redView: UIView = {
              let view = UIView()
              view.backgroundColor = .red
            view.autoresizingMask = [.flexibleTopMargin,.flexibleLeftMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleWidth]
              return view
          }()

    private let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0,y: 0,width: 200,height: 20))
        label.text = "Without Storyboard :)"
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }

    override func viewWillLayoutSubviews() {
        if greenView.superview == nil {
            view.addSubview(greenView)
            let containerWidth = view.bounds.width
            let containerHeigh = view.bounds.height
            let greenWidth = containerWidth - paddingGreen*2
            let greenHeigh = containerHeigh - paddingGreen*2
            greenView.frame = CGRect (x: paddingGreen, y: paddingGreen, width: greenWidth, height: greenHeigh)
        }

        if redView.superview == nil {
            greenView.addSubview(redView)
            let redWidth = greenView.bounds.width - paddingGreen
            let redHeigh:CGFloat = 100.0
            redView.frame = CGRect (x: paddingGreen/2, y: view.bounds.height/2-paddingGreen*2, width: redWidth, height: redHeigh)
        }

        if label.superview == nil {
            redView.addSubview(label)
        }
    }
}

// let containerWidth = bounds.width
// let containerHeigh = bounds.height
//
//  let greenWidth = containerWidth - paddingGreen
//  let greenHeigh = containerHeigh - paddingGreen
//
//  let redWidth = greenWidth-50
//  let redHeigh:CGFloat = 100.0
//
//
// greenView.frame = CGRect (x: paddingGreen, y: paddingGreen, width: greenWidth, height: greenHeigh)
//redView.frame = CGRect (x: paddingGreen/2, y: greenHeigh/2-50, width: redWidth, height: redHeigh)
