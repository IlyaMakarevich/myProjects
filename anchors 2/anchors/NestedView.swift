//
//  NestedView.swift
//  anchors
//
//  Created by Ilya Makarevich on 11/22/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class NestedView: UIView {
    
    private let padding: CGFloat = 25.0
    private let spacing: CGFloat = 50.0

    private let blueView = UIView.makeView(color: .blue)
    private let redView = UIView.makeView(color: .red)

   override init(frame: CGRect) {
           super.init(frame: frame)
           setupView()
       }

       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setupView()
       }


    private func setupView() {
        addSubview(redView)
        addSubview(blueView)
        
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            blueView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: padding),
            blueView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: padding),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor, constant: padding),

            redView.leadingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: redView.trailingAnchor,constant: padding),
            redView.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: padding),
            redView.widthAnchor.constraint(equalTo: blueView.widthAnchor)
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
