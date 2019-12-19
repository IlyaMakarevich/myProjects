//
//  ViewController.swift
//  youtube_lesson4
//
//  Created by MacBook Pro  on 15.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let padding: CGFloat = 70.0
    
    let mySwitch = UISwitch()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       setupSwitch()
        setupButton()
    }
    


    func setupSwitch () {
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mySwitch)
        NSLayoutConstraint.activate([
            mySwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        self.mySwitch.addTarget(self, action: #selector(switchChanged(paramTarget:)), for: .valueChanged)
        self.mySwitch.tintColor = UIColor.green
        self.mySwitch.onTintColor = UIColor.red
    }
    
    func setupButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("MY BUTTON", for: .normal)
        button.setTitle("pressed", for: .highlighted)
        button.backgroundColor = .green
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50.0),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 300.0)
        ])
        
    }
    
    @objc func switchChanged(paramTarget: UISwitch) {
        print("param is = ", paramTarget)
        if paramTarget.isOn{
            print("sw on")
            self.button.isUserInteractionEnabled = true
        } else {
            print("sw off")
            self.button.isUserInteractionEnabled = false
        }
    }

}

