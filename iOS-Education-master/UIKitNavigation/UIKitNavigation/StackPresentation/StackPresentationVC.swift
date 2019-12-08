//
//  StackPresentationVC.swift
//  UIKitNavigation
//
//  Created by Ruslan Sabirov on 05.12.2019.
//  Copyright © 2019 Ruslan Sabirov. All rights reserved.
//

import UIKit

class StackPresentationVC: UIViewController {
    
    lazy var nextButton = NextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVC()
    }
    
    @objc func nextAction() {
    navigationController?.pushViewController(StackPresentationNextVC(), animated: true)
    }
    
    func setupVC() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Stack Presentation VC"
        nextButton.anchorToCenter(view, width: NextButton.buttonWidth)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
}
