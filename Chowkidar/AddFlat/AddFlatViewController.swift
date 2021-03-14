//
//  AddFlatViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 28/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class AddFlatViewController: UIViewController {

    @IBOutlet weak var meassageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        meassageLabel.text = "Hi Vijay! \r\nCurrently you are not a part of any community. Please complete the below fields to add flat."

        // Do any additional setup after loading the view.
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
