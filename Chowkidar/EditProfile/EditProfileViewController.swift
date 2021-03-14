//
//  EditProfileViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 2/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileViewController: BaseViewController {
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var noneButton: UIButton!
    
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var doctorButton: UIButton!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.myTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone(sender:datePicker1:)))
        setDatePicker()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Edit profile")
        saveButton.setCornerRadiusButton(value: 10)
       // getProfileData()
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func genderClickAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            sender.isSelected = true
            femaleButton.isSelected = false
            noneButton.isSelected = false
        case 1:
            sender.isSelected = true
            maleButton.isSelected = false
            noneButton.isSelected = false
        case 2:
            sender.isSelected = true
            maleButton.isSelected = false
            femaleButton.isSelected = false
        default:
            print("")
        }
        
    }
    
    
    @IBAction func professionButtonAction(_ sender: UIButton) {
        
        switch sender.tag {
             case 3:
                 sender.isSelected = true
                 teacherButton.isSelected = false
                 professorButton.isSelected = false
             case 4:
                 sender.isSelected = true
                 doctorButton.isSelected = false
                 professorButton.isSelected = false
             case 5:
                 sender.isSelected = true
                 teacherButton.isSelected = false
                 doctorButton.isSelected = false
             default:
                 print("")
             }
    }
    
    @IBAction func preferButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
        datePicker.set18YearValidation()
    }

    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        if let fullName = fullNameTextField.text {
            if Validation.isNotEmpty(textField: fullNameTextField) {
                if Validation.isValid(name: fullName) {
                    let headers: HTTPHeaders = [
                        "accept": "application/json",
                        "content-type": "application/json"
                    ]
                    
                    let params: [String: Any] = [
                         "accessId" : 7600,
                         "userId" : 7600,
                         "name": fullName,
                         "gender":1,
                         "dob":"12/12/2020",
                         "image":"",
                         "emailId":"a.sengupta17@gmail.com",
                         "professionId":1,
                         "isVisibleToEverybody":false
                    ]
                    
                    NetworkManager.post_Request(urlService: kUpdateProfile, param: params, head: headers, responseType: updateProfileDataModel.self) { (response, statusCode) in
                        if response != nil {
                            guard let responseData = response as? updateProfileDataModel else {
                                return
                            }
                            if statusCode == 200 {
                                Loader.showToast(message: responseData.message! , onView: self.view, bottomMargin: 200)
                              //  self.performSegue(withIdentifier: "loginToOtp", sender: nil)
                            } else {
                                Loader.showAlert(message: responseData.message! )
                            }
                        }
                    }
                } else {
                    Loader.showToast(message: "Please enter valid mobile number", onView: self.view, bottomMargin: 200)
                }
            } else {
                Loader.showToast(message: "Please enter mobile number", onView: self.view, bottomMargin: 200)
            }
        }
    }
    

}

extension UIDatePicker {
func set18YearValidation() {
    let currentDate: Date = Date()
    var calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    var components: DateComponents = DateComponents()
    components.calendar = calendar
    components.year = -30
    let maxDate: Date = calendar.date(byAdding: components, to: currentDate)!
    components.year = -150
    let minDate: Date = calendar.date(byAdding: components, to: currentDate)!
    self.minimumDate = minDate
    self.maximumDate = maxDate
} }


extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
