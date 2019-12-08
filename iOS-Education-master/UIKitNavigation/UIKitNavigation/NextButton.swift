//
//  NextButton.swift
//  UIKitNavigation
//
//  Created by Ruslan Sabirov on 05.12.2019.
//  Copyright © 2019 Ruslan Sabirov. All rights reserved.
//

import UIKit

class NextButton: UIButton {
   
   static let buttonWidth = CGFloat(100)
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("Next ->", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        titleLabel?.textColor = .black
        backgroundColor = .lightGray
        layer.cornerRadius = 2
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
