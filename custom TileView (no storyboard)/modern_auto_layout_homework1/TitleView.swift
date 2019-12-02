//
//  rootView.swift
//  modern_auto_layout_homework1
//
//  Created by Ilya Makarevich on 11/20/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class TitleView: UIView {


  var paddingGreen: CGFloat = 50.0 {
        didSet {
            setNeedsLayout()
        }
    }


   private let greenView: UIView = {
            let view = UIView()
            view.backgroundColor = .green
            return view
        }()

        private let redView: UIView = {
            let view = UIView()
            view.backgroundColor = .red
            return view
        }()

   override init (frame: CGRect) {
         super.init(frame: frame)
         setupView()
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupView()
     }

     private func setupView() {
         addSubview(greenView)
         addSubview(redView)
     }

    override func layoutSubviews() {
           super.layoutSubviews()

           let containerWidth = bounds.width
           let containerHeigh = bounds.height

            let greenWidth = containerWidth - paddingGreen
            let greenHeigh = containerHeigh - paddingGreen

            let redWidth = greenWidth-50
            let redHeigh:CGFloat = 100.0


           greenView.frame = CGRect (x: paddingGreen, y: paddingGreen, width: greenWidth, height: greenHeigh)
          redView.frame = CGRect (x: paddingGreen/2, y: greenHeigh/2-50, width: redWidth, height: redHeigh)
       }
}
