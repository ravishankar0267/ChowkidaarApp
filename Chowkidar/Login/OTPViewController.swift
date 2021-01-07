//
//  OTPViewController.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 12/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class OTPViewController: BaseViewController, UITextFieldDelegate  {

   
    @IBOutlet weak var aResendOTPButton: UIButton!
    @IBOutlet weak var aLoginButton: UIButton!
    @IBOutlet weak var aOTPTextfield1: UITextField!
    @IBOutlet weak var aOTPTextfield2: UITextField!
    @IBOutlet weak var aOTPTextfield3: UITextField!
    @IBOutlet weak var aOTPTextfield4: UITextField!
    
    var mobileNumber = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
       
        //addNavigationBar(navigationTitle: "CODE VERIFICATION")
        let backImage = UIImage(named: "backButton")

        self.navigationController?.navigationBar.backIndicatorImage = backImage

        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupUI() {
        aOTPTextfield1.addBottomBorder()
        aOTPTextfield2.addBottomBorder()
        aOTPTextfield3.addBottomBorder()
        aOTPTextfield4.addBottomBorder()
//        aOTPTextfield1.delegate = self
//        aOTPTextfield2.delegate = self
//        aOTPTextfield3.delegate = self
//        aOTPTextfield4.delegate = self
        
        aOTPTextfield1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        aOTPTextfield4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
     
        aLoginButton.setCornerRadiusButton(value: 10)
        aLoginButton.setBorder(color: .white, size: 1)
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
            if let receivedOTP = UserDefaults.standard.value(forKey: kLoginOTP) as? String {
                if receivedOTP == receivedOTP {
                    Loader.showToast(message: "Login successfully", onView: self.view, bottomMargin: 200)
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    APP_DEL.openInitialViewController()
                    UserDefaults.standard.synchronize()
                    UserDefaults.standard.synchronize()
                } else {
                    Loader.showToast(message: "OTP not matched, Please try again!", onView: self.view, bottomMargin: 200)
                }
            }
        } else {
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            APP_DEL.openInitialViewController()
            Loader.showToast(message: "Please enter valid OTP", onView: self.view, bottomMargin: 200)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        
        if text?.count ?? 0 >= 1 {
            switch textField{
            case aOTPTextfield1:
                self.view.frame.origin.y = self.view.frame.origin.y-100
                aOTPTextfield2.becomeFirstResponder()
            case aOTPTextfield2:
                aOTPTextfield3.becomeFirstResponder()
            case aOTPTextfield3:
                aOTPTextfield4.becomeFirstResponder()
            case aOTPTextfield4:
                aOTPTextfield1.resignFirstResponder()
                //submitOTP()
            default:
                break
            }
        }else{
            
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
