//
//  ModalPresentationVC.swift
//  Telegram_task1_code
//
//  Created by Ilya Makarevich on 12/8/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ModalPresentationVC: UIViewController {

    let nextButton = NextButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }

    func setupVC() {
        view.backgroundColor = .red
        view.addSubview(nextButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Modal Presentation VC"
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.anchorToCenter(view, width: 100.0)
    }

    @objc func nextAction() {
    self.present(ModalPresentationNextVC(), animated: true, completion: nil)
        nextButton.shake()
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

