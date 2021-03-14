//
//  OTPViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.

import UIKit
import Alamofire

class OTPViewController: BaseViewController, UITextFieldDelegate  {
    @IBOutlet weak var termsAndConditionLabel: UILabel!
    @IBOutlet weak var whiteBackgroundHeightConstratint: NSLayoutConstraint!
    @IBOutlet weak var aResendOTPButton: UIButton!
    @IBOutlet weak var aLoginButton: UIButton!
    @IBOutlet weak var aOTPTextfield1: UITextField!
    @IBOutlet weak var aOTPTextfield2: UITextField!
    @IBOutlet weak var aOTPTextfield3: UITextField!
    @IBOutlet weak var aOTPTextfield4: UITextField!
    let text = "By Logging In, You Accept Our Terms & Conditions And Privacy Policy."
    @IBOutlet weak var aBackButton: UIButton!
    var mobileNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if(DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS){
            whiteBackgroundHeightConstratint.constant = 300
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        handleBackButtonAction()
    }
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        aOTPTextfield1.addBottomBorder()
        aOTPTextfield2.addBottomBorder()
        aOTPTextfield3.addBottomBorder()
        aOTPTextfield4.addBottomBorder()
        aOTPTextfield1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aLoginButton.setCornerRadiusButton(value: 10)
        aLoginButton.setBorder(color: .white, size: 1)
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
    
    
    @IBAction func resendOTPButtonAction(_ sender: Any) {
        if Connectivity.isConnectedToInternet {
            Loader.showToast(message: "OTP sent successfully", onView: self.view, bottomMargin: 200)
        } else {
            Loader.showAlert(message: "Please check your internet connection!")
        }
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet {
            submitOTP()
        } else {
            Loader.showAlert(message: "Please check your internet connection!")
        }
    }
    
    func submitOTP() {
        let first = aOTPTextfield1.text ?? ""
        let second = aOTPTextfield2.text ?? ""
        let third = aOTPTextfield3.text ?? ""
        let fourth = aOTPTextfield4.text ?? ""
        let inputOTP = first + second + third + fourth
        if inputOTP != "" {
            let headers: HTTPHeaders = [
                "accept": "application/json",
                "content-type": "application/json",
            ]
            
            
            let params: [String: Any] = [
                "mobileNumber": mobileNumber,
                "request_id": "caa37c3201f744daa733317b19f11c77",
                "code": inputOTP
            ]
            self.showActivityIndicator(sMessage: "Submitting OTP")
            NetworkManager.post_Request(urlService: kVerifySMS, param: params, head: headers, responseType: VerifySMSDataModel.self) { (response, statusCode) in
                self.hideActivityIndicator()
                if response != nil {
                    guard let responseData = response as? VerifySMSDataModel else {
                        return
                    }
                    if statusCode == 200 {
                        Loader.showToast(message: responseData.message ?? "Invalid message data", onView: self.view, bottomMargin: 200)
                        self.registerUserToken(otpResponse: response as! VerifySMSDataModel)
                        
                    } else {
                        Loader.showAlert(message: responseData.message ?? "Invalid message data")
                    }
                }
            }
        } else {
            Loader.showToast(message: "Please enter valid OTP", onView: self.view, bottomMargin: 200)
        }
    }
    
    func registerUserToken(otpResponse:VerifySMSDataModel)  {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        let params: [String: Any] = [
            "accessId" : otpResponse.userId ?? "",
            "userId" : otpResponse.userId ?? "",
            "deviceId": deviceIdentifier ?? "",
            "deviceToken": otpResponse.token ?? "",
            "clientType" : 1
        ]
        self.showActivityIndicator(sMessage: "Registering Token")
        NetworkManager.post_Request(urlService: kRegsiterToken, param: params, head: headers, responseType: RegsiterTokenDataModel.self) { (response, statusCode) in
            self.hideActivityIndicator()
            if response != nil {
                print("RegsiterTokenDataModel ===", response!)
                guard let responseData = response as? RegsiterTokenDataModel else {
                    return
                }
                if statusCode == 200 {
                    Loader.showToast(message: responseData.message ?? "Invalid message data", onView: self.view, bottomMargin: 200)
                    print("Regsietr data Modal response",responseData.message!)
                    self.getOwnersFlat(otpResponse: otpResponse)
                    
                } else {
                    Loader.showAlert(message: responseData.message ?? "Invalid message data")
                }
            }
        }
    }
    
    func getOwnersFlat(otpResponse:VerifySMSDataModel)  {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        let params: [String: Any] = [
            "accessId" : otpResponse.userId!,
            "userId" : otpResponse.userId!
        ]
        NetworkManager.post_Request(urlService: kGetOwnersFlat, param: params, head: headers, responseType: OwnersFlatDataModel.self) { (response, statusCode) in
            if response != nil {
                guard let responseData = response as? OwnersFlatDataModel else {
                    return
                }
                if statusCode == 200 {
                    if(responseData.count > 0){
                       let response = responseData[0] as onwersFlatDataModelElement
                        self.saveLoginDataInUserDefault(inputData: response)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        UserDefaults.standard.synchronize()
                        UserDefaults.standard.synchronize()
                        APP_DEL.openInitialViewController()
                    }
                    else {
                    }
                    
                }
                else {
                    Loader.showAlert(message: "Invalid flat response")
                    
                }
            }
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if text?.count ?? 0 >= 1 {
            switch textField{
            case aOTPTextfield1:
                aOTPTextfield2.becomeFirstResponder()
            case aOTPTextfield2:
                aOTPTextfield3.becomeFirstResponder()
            case aOTPTextfield3:
                aOTPTextfield4.becomeFirstResponder()
            case aOTPTextfield4:
                aOTPTextfield1.resignFirstResponder()
                submitOTP()
            default:
                break
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        let  char = textField.text!.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            print("Backspace was pressed")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func saveLoginDataInUserDefault(inputData:onwersFlatDataModelElement)
    {
        UserDefaults.standard.set(inputData.userID!, forKey: kUserID)
        UserDefaults.standard.set(inputData.userID!, forKey: kAccessId)
        UserDefaults.standard.set(inputData.complexID!, forKey: kComplexID)
        UserDefaults.standard.set(inputData.flatNumber!, forKey: kFaltNo)
        UserDefaults.standard.set(inputData.wing!, forKey: kWing)
                                        UserDefaults.standard.synchronize()
        
    }
    
}


extension UITextField
{
    func addBottomBorder()  {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.size.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
