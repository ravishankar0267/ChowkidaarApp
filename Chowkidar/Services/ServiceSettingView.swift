//
//  ServiceSettingView.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 1/2/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit
enum LanguageSelection:Int {
    case english = 1
    case kanadda
    case hindi
    case teglu
    case marathi
}

enum ServiceSelection:Int {
    case domestichelp = 6
    case cook
    case plumber
}

class ServiceSettingView: UIView {

    @IBOutlet weak var ServiceStackView: UIStackView!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var kanddaButton: UIButton!
    @IBOutlet weak var hindiButton: UIButton!
    @IBOutlet weak var telguButton: UIButton!
    @IBOutlet weak var marathiButton: UIButton!
    @IBOutlet weak var domesticHelpButton: UIButton!
    @IBOutlet weak var plumberButton: UIButton!
    @IBOutlet weak var cookButton: UIButton!
    @IBOutlet weak var SliderView: UIView!
    var lanugaeSelection = LanguageSelection.english
    var serviceSelection = ServiceSelection.domestichelp
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupLanguageButtonBorder()  {
        if(DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS){
        ServiceStackView.spacing = 10
        languageStackView.spacing = 10
        }
        self.setBoderAndCornerRadius(aButton: englishButton)
        self.setBoderAndCornerRadius(aButton: kanddaButton)
        self.setBoderAndCornerRadius(aButton: hindiButton)
        self.setBoderAndCornerRadius(aButton: telguButton)
        self.setBoderAndCornerRadius(aButton: marathiButton)
        self.setBoderAndCornerRadius(aButton: domesticHelpButton)
        self.setBoderAndCornerRadius(aButton: plumberButton)
        self.setBoderAndCornerRadius(aButton: cookButton)
        setBoderAndCornerRadiusForApplyAndResetButton()
    }
    
    func setBoderAndCornerRadius(aButton:UIButton){
        aButton.setCornerRadiusButton(value: 3)
        aButton.setBorderButton(color: UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1), size: 1)
    }
    
    func setBoderAndCornerRadiusForApplyAndResetButton(){
        resetButton.setCornerRadiusButton(value: 5)
        resetButton.setBorderButton(color: UIColor(red: 248/255, green: 134/255, blue: 32/255, alpha: 1), size: 3)
        applyButton.setCornerRadiusButton(value: 5)
        applyButton.setBorderButton(color: UIColor(red: 248/255, green: 134/255, blue: 32/255, alpha: 1), size: 3)
    }
    @IBAction func languageSelection(_ sender: UIButton) {
        switch sender.tag {
        case 1,2,3,4,5:
            if(sender.isSelected){
            }
            else {
                lanugaeSelection = LanguageSelection(rawValue: sender.tag) ?? LanguageSelection(rawValue: 0)!
                print(lanugaeSelection)
                setLangaugeButtonState(tag: sender.tag)
            }
        default: break
        }
    }
    
    func setLangaugeButtonState(tag:Int)  {
        for i in 1...5 {
            let button = self.viewWithTag(i) as! UIButton
            if(tag == i){
                button.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
                button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
                } else {
                button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                button.setTitleColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1), for: .normal)
            }
        }
    }
    
    func setServiceButtonState(tag:Int)  {
        for i in 6...8 {
            let button = self.viewWithTag(i) as! UIButton
            if(tag == i){
                button.backgroundColor = UIColor(red: 0/255, green: 103/255, blue: 124/255, alpha: 1)
                button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
                } else {
                button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
                button.setTitleColor(UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1), for: .normal)
            }
        }
    }
    
    @IBAction func serviceSelectionAction(_ sender: UIButton) {
        switch sender.tag {
        case 6,7,8:
            if(sender.isSelected){
            }
            else {
                serviceSelection = ServiceSelection(rawValue: sender.tag) ?? ServiceSelection(rawValue: 0)!
                print(lanugaeSelection)
                setServiceButtonState(tag: sender.tag)
            }
        default: break
        }
    }
}
