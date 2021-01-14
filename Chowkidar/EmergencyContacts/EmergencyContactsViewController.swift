//
//  EmergencyViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 2/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class EmergencyContactsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Emergency contacts")
       // getProfileData()
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
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
