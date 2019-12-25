//
//  InfinityScrollActivityView.swift
//  TwitterTest
//
//  Created by Константин on 01.04.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class InfinityScrollActivityView: UIView {
    var activityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight: CGFloat = 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActivityindicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityindicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2)
    }
    
    func setupActivityindicator() {
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func startAnimation() {
        self.hidden = false
        self.activityIndicatorView.startAnimating()
    }
    
    func stopAnimation() {
        self.activityIndicatorView.stopAnimating()
        self.hidden = true
    }
}
