//
//  ModalPresentationNextVC.swift
//  UIKitNavigation
//
//  Created by Ruslan Sabirov on 05.12.2019.
//  Copyright © 2019 Ruslan Sabirov. All rights reserved.
//

import UIKit

class ModalPresentationNextVC: UIViewController {
    
    private let buttonWidth = 100
    
    lazy var backButton = BackButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    func setupVC() {
        view.backgroundColor = .white
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backButton.anchorToCenter(view, width: BackButton.buttonWidth)
    }
    
    @objc func backAction() {
    dismiss(animated: true, completion: nil)
    }
}
