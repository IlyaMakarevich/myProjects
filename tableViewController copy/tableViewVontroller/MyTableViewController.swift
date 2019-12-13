//
//  MyTableViewController.swift
//  tableViewVontroller
//
//  Created by MacBook Pro  on 11.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var polSegment: UISegmentedControl!
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load data
        if let name = userDefaults.object(forKey: "name") {
            nameTextField.text = name as? String
        }
        if let lastName = userDefaults.object(forKey: "lastName") {
            lastNameTextField.text = lastName as? String
        }
        if let switcherState = userDefaults.object(forKey: "switch") {
            switcher.isOn = switcherState   as! Bool
        }
        if let pol = userDefaults.object(forKey: "segment") {
            polSegment.selectedSegmentIndex = pol as! Int
        }
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        userDefaults.set(nameTextField.text, forKey: "name")
        userDefaults.set(lastNameTextField.text, forKey: "lastName")
        userDefaults.set(switcher.isOn, forKey: "switch")
        userDefaults.set(polSegment.selectedSegmentIndex, forKey: "segment")
        print("saved!")
        lastNameTextField.resignFirstResponder()

    }
}
