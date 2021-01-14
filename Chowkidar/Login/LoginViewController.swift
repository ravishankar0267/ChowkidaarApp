//
//  LoginViewController.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 12/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var aLoginTextField: UITextField!
    @IBOutlet weak var aLoginLabel: UILabel!
    @IBOutlet weak var aNextButton: UIButton!
    
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    var loginDataModel: LoginDataModel?
    let text = "By Logging In, You Accept Our Terms & Conditions And Privacy Policy."
    override func viewDidLoad() {
        super.viewDidLoad()
        aLoginTextField.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        aLoginTextField.text = "8147912838"
    }
    
    func setupUI() {
        termsAndConditionLabel.text = text
        let linkColor = UIColor(red: 0/255, green: 69/255, blue: 86/255, alpha: 1)
        self.termsAndConditionLabel.font =  UIFont.OpenSans(.regular, size: 16)
        let attriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions")
        let range2 =  (text as NSString).range(of: "Privacy Policy.")
                attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.OpenSans(.regular, size: 14), range: range1)
        attriString.addAttribute(NSAttributedString.Key.font, value: UIFont.OpenSans(.regular, size: 14), range: range2)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: linkColor, range: range1)
        attriString.addAttribute(NSAttributedString.Key.foregroundColor, value: linkColor, range: range2)
        termsAndConditionLabel.attributedText = attriString
        termsAndConditionLabel.isUserInteractionEnabled = true
        termsAndConditionLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        aNextButton.setCornerRadiusButton(value: 10)
    }
    
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
       let termsRange = (text as NSString).range(of: "Terms & Conditions")
       // comment for now
       let privacyRange = (text as NSString).range(of: "Privacy Policy.")

       if gesture.didTapAttributedTextInLabel(label: termsAndConditionLabel, inRange: termsRange) {
           print("Tapped terms")
       }
        else if gesture.didTapAttributedTextInLabel(label: termsAndConditionLabel, inRange: privacyRange) {
           print("Tapped privacy")
       }
        else {
           print("Tapped none")
       }
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        sendOTPWithMobileNo()
    }
    
    
    func sendOTPWithMobileNo()  {
        
        self.performSegue(withIdentifier: "loginToOtp", sender: nil)
        if let mobileNumber = aLoginTextField.text {
            if Validation.isNotEmpty(textField: aLoginTextField) {
                if Validation.isValid(mobileNo: mobileNumber) {
//                    NetworkManager.post_Request(urlService: <#T##String#>, param: <#T##[String : Any]?#>, head: nil, responseType: loginDataModel.self) { (<#Any?#>) in
//                        <#code#>
//                    }
                    
//                    //self.performSegue(withIdentifier: "loginToOtp", sender: nil)
//                    NetworkManager.generateURLWithQueryParam(baseURL: kBASE_URL, componentURL: URL_SendSMS, queryItems: [URLQueryItem.init(name: "mobile", value: mobileNumber)]) { (responseURL) in
//                        if let finalURL = responseURL as? URL {
//                            NetworkManager.get_Request(requestURL: finalURL) { (response) in
//                                do {
//                                    if response != nil {
//                                        let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                                        let responseModel = try JSONDecoder().decode(LoginDataModel.self, from: responseData)
//                                        self.loginDataModel = responseModel
//                                        self.saveLoginDataInUserDefault()
//                                    }
//                                } catch {
//                                    Loader.showAlert(message: requestFailureError)
//                                }
//                            }
//                        }
//                    }
                } else {
                    Loader.showToast(message: "Please enter valid mobile number", onView: self.view, bottomMargin: 200)
                }
            } else {
                Loader.showToast(message: "Please enter mobile number", onView: self.view, bottomMargin: 200)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToOtp" {
            if let otpVC = segue.destination as? OTPViewController {
                if let mobileNumber = aLoginTextField.text {
                    otpVC.mobileNumber = mobileNumber
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let currentCharacterCount = textField.text?.count ?? 0
           if range.length + range.location > currentCharacterCount {
               return false
           }
           let newLength = currentCharacterCount + string.count - range.length
//        if(newLength == 11){
//            textField.resignFirstResponder()
//            sendOTPWithMobileNo()
//        }
           return newLength <= 10
        
//        var shouldContinueEditing = true
//        // return NO to not change text
//        let text = textField.text
//
//        if text?.count ?? 0 > 10 {
//            shouldContinueEditing = false
//            textField.resignFirstResponder()
//            sendOTPWithMobileNo()
//            if(text?.count == 11){
//                shouldContinueEditing = false
//            }
//
//            print("text count ====", text!.count)
       // }
        
       // return shouldContinueEditing
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        // called when clear button pressed. return NO to ignore (no notifications)
        return true
    }
    
    
    
    func saveLoginDataInUserDefault() {
        if let loginData = loginDataModel {
            if let loginResult = loginData.results {
                if loginResult.count > 0 {
                    let loginInfo = loginResult[0]
                    if let reseultError = loginInfo.error, reseultError != "" {
                        Loader.showToast(message: reseultError, onView: self.view, bottomMargin: 200)
                    } else {
                        if let loginOtp = loginInfo.otp,
                            let loginMobileNumber = loginInfo.mobile,
                            let loginID = loginInfo.id,
                            let loginType = loginInfo.type {
                            if loginOtp != "" {
                                Loader.showToast(message: "OTP sent successfully", onView: self.view, bottomMargin: 200)
                                self.performSegue(withIdentifier: "loginToOtp", sender: nil)
                                UserDefaults.standard.set(loginOtp, forKey: kLoginOTP)
                                UserDefaults.standard.set(loginID, forKey: kLoginID)
                                UserDefaults.standard.set(loginType, forKey: kLoginType)
                                UserDefaults.standard.set(loginMobileNumber, forKey: kLoginMobileNumber)
                                UserDefaults.standard.synchronize()
                            } else {
                                Loader.showToast(message: "Unable to send OTP, Please try again!", onView: self.view, bottomMargin: 200)
                            }
                        }
                    }
                }
            }
        }
    }
}
