//
//  CustomPickerView.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 28/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import Foundation
import UIKit

 
class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
 
    var pickerData : [String]!
    var pickerTextField : UITextField!
 
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame:CGRect.zero )
 
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
 
        self.delegate = self
        self.dataSource = self
        
        
  DispatchQueue.main.async {
        
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // Sets number of columns in picker view
    // MARK: UIPickerView Delegation

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return pickerData[row]
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
    
}

extension UITextField {
func loadDropdownData(data: [String]) {
    self.inputView = MyPickerView(pickerData: data, dropdownField: self)
    
    }

        func setInputViewDatePicker(target: Any, selector: Selector) {
            // Create a UIDatePicker object and assign to inputView
            let screenWidth = UIScreen.main.bounds.width
            let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
            datePicker.datePickerMode = .date //2
            self.inputView = datePicker //3

            // Create a toolbar and assign it to inputAccessoryView
            let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
            let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
            let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
            let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
            toolBar.setItems([cancel, flexible, barButton], animated: false) //8
            self.inputAccessoryView = toolBar //9

        }
    
    func setInputViewTimePicker(target: Any, selector: Selector) {
              // Create a UIDatePicker object and assign to inputView
              let screenWidth = UIScreen.main.bounds.width
              let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
              datePicker.datePickerMode = .time //2
        let dateFormatter = DateFormatter()
                   dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                   dateFormatter.timeZone = TimeZone.autoupdatingCurrent
                   dateFormatter.timeStyle = DateFormatter.Style.short
              self.inputView = datePicker //3

              // Create a toolbar and assign it to inputAccessoryView
              let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
              let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
              let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
              let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
              toolBar.setItems([cancel, flexible, barButton], animated: false) //8
              self.inputAccessoryView = toolBar //9

          }

        @objc func tapCancel() {
            self.resignFirstResponder()
        }

}


