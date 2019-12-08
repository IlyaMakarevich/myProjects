//
//  ViewController.swift
//  viewController cycle
//
//  Created by MacBook Pro  on 02.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let padding: CGFloat = 25.0
    private enum AnimationMetrics {
          static let offset: CGFloat = -200
          static let duration: TimeInterval = 6.0
          static let delay: TimeInterval = 7.0
          static let damping: CGFloat = 0.4
      }
    
    let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        print("view did load")
    }

    
    func setupView() {
        view.addSubview(redView)
        NSLayoutConstraint.activate([
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10*padding),
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        redView.topAnchor.constraint(equalTo: view.topAnchor),
        redView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
//        let width = view.bounds.width - 2*padding
//        redView.frame = CGRect(x: padding, y: padding, width: width, height: 3*padding)
//        print("view did load")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton(withDuration: AnimationMetrics.duration, damping: AnimationMetrics.damping, delay: AnimationMetrics.delay)
    print("view did appear")
    }
    
    private func animateButton(withDuration duration: TimeInterval, damping: CGFloat, delay: TimeInterval = 0) {
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: damping, animations: {
            self.view.layoutIfNeeded()
        })
        animator.startAnimation(afterDelay: delay)
    }
    
    override func viewWillLayoutSubviews() {
        print("view did layput subview")
    }
    

}

