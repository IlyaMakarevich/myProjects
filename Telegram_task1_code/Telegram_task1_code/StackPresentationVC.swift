//
//  StackPresentationVC.swift
//  Telegram_task1_code
//
//  Created by Ilya Makarevich on 12/8/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class StackPresentationVC: UIViewController {

    let nextButton = NextButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        nextButton.setTitle("Next", for: .normal)
    }
    
    func setupVC() {
        view.backgroundColor = .darkGray
        view.addSubview(nextButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Stack Presentation VC"
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.anchorToCenter(view, width: 100.0)
    }
    
    @objc func nextAction() {
        let stackPresentationNextVC = StackPresentationNextVC()
        if let navigator = navigationController {
              navigator.pushViewController(stackPresentationNextVC, animated: true)
          }
        nextButton.shake()
     }

}
