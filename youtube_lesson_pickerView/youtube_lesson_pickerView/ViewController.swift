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
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
        setupLabel()
    }
    
    
    func setupPicker() {
        view.addSubview(picker)
        picker.center = view.center
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }

    func setupLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor,constant: 100.0)]
        )
        label.text = "what you gonna select?"
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
        label.text = myArray[row]
    }


    
    
}

