//
//  ModalPresentationNextVC.swift
//  Telegram_task1_code
//
//  Created by Ilya Makarevich on 12/8/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

class ModalPresentationNextVC: UIViewController {
    
    let backButton = BackButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        backButton.setTitle("Close", for: .normal)
    }
    
    @objc func goBack() {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupVC() {
        view.backgroundColor = .green
        view.addSubview(backButton)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Modal Presentation VC"
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.anchorToCenter(view, width: 100.0)
    }
    

}
