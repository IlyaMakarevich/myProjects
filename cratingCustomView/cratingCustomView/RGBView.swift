//
//  RGBView.swift
//  cratingCustomView
//
//  Created by Ilya Makarevich on 11/20/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

@IBDesignable
class RGBView: UIView {

    let spacing:CGFloat = 20.0

    override init (frame: CGRect) {
         super.init(frame: frame)
         setupView()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupView()
     }


    private let redView: UIView = {
           let view = UIView()
           view.backgroundColor = .red
           return view
       }()

    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

       private let blueView: UIView = {
           let view = UIView()
           view.backgroundColor = .blue
           return view
       }()

    private func setupView() {
        addSubview(redView)
        addSubview(greenView)
        addSubview(blueView)
       }


    override func layoutSubviews() {
           super.layoutSubviews()
        redView.frame = CGRect (x: 0 , y: 0, width: bounds.width, height: (bounds.height - spacing*2)/3)

        greenView.frame = CGRect (x: 0, y: (spacing+bounds.height - spacing*2)/3 + spacing, width: bounds.width, height: (bounds.height - spacing*2)/3)

        blueView.frame = CGRect (x: 0, y: 2*(spacing+bounds.height - spacing*2)/3 + 2*spacing, width: bounds.width, height: (bounds.height - spacing*2)/3)

       }
}
