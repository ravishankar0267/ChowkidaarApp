//
//  EditProfileViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 2/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class EditProfileViewController: BaseViewController {
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var noneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Edit profile")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
