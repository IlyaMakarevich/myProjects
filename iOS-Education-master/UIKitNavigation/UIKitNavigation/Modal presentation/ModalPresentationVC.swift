//
//  ModalPresentationVC.swift
//  UIKitNavigation
//
//  Created by Ruslan Sabirov on 05.12.2019.
//  Copyright © 2019 Ruslan Sabirov. All rights reserved.
//

import UIKit

class ModalPresentationVC: UIViewController {

    lazy var nextButton = NextButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func setupVC() {
        view.backgroundColor = .white
        view.addSubview(nextButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Modal Presentation VC"
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.anchorToCenter(view, width: NextButton.buttonWidth)
    }
    
    @objc func nextAction() {
    self.present(ModalPresentationNextVC(), animated: true, completion: nil)
    }
}

extension UIView {
    func anchorToCenter(_ superView: UIView?, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superView else {return}
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
