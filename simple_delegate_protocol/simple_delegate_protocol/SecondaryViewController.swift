//
//  SecondaryViewController.swift
//  simple_delegate_protocol
//
//  Created by Ilya Makarevich on 12/4/19.
//  Copyright © 2019 apalon. All rights reserved.
//

import UIKit

protocol SecondaryViewControllerDelegate: AnyObject {
    func testFunction(_ sender: UIButton)
}

class SecondaryViewController: UIViewController {

    weak var delegate: SecondaryViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func testFunction(_ sender: UIButton) {
        delegate?.testFunction(self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
