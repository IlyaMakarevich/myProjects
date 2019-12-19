//
//  ViewController.swift
//  youtube_lesson_pickerView
//
//  Created by MacBook Pro  on 17.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let myArray = ["Ilya", "Natallia", "Olivia"]
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
    }
    
    
    func setupPicker() {
        view.addSubview(picker)
        picker.center = view.center
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }
}



extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(myArray[row])
    }
    
    
}

