//
//  NestedView.swift
//  anchors
//
//  Created by Ilya Makarevich on 11/22/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class NestedView: UIView {

    private let padding: CGFloat = 70.0
    private let spacing: CGFloat = 10.0

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

   override init(frame: CGRect) {
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
        NSLayoutConstraint.activate([
            greenView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: padding),
            greenView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: greenView.bottomAnchor, constant: padding),

            redView.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: spacing),
            trailingAnchor.constraint(equalTo: redView.trailingAnchor,constant: spacing+padding),
            redView.heightAnchor.constraint(equalTo: greenView.heightAnchor, multiplier: 0.2),
            redView.centerYAnchor.constraint(equalTo: centerYAnchor),

            //equalToSystemSpacingAfter
//     constraint(greaterThanOrEqualToSystemSpacingAfter
 // anchor:multiplier:)
//constraint(lessThanOrEqualToSystemSpacingAfter
  //anchor:multiplier:)
        ])

    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
