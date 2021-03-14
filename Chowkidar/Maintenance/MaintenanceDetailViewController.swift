//
//  MaintenanceDetailViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 4/2/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class MaintenanceDetailViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var bookHallButton: UIButton!
    @IBOutlet weak var MaitenanceDetailBgView: UIView!
    var paymentSuccessView: PaymentSuccessView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MaitenanceDetailBgView.setCornerRadius(value: 10)
        self.MaitenanceDetailBgView.backgroundColor = .white
        self.MaitenanceDetailBgView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
        self.bookHallButton.setCornerRadius(value: 10)
        self.homeButton.setCornerRadius(value: 10)

        // Do any additional setup after loading the view.
    }
    
    func CreateSuccess()  {
        paymentSuccessView = Bundle.main.loadNibNamed("PaymentSuccessView", owner: self, options: nil)?.first as? PaymentSuccessView
        paymentSuccessView?.frame = CGRect(x: 0, y: 490, width: ScreenSize.SCREEN_WIDTH, height: 20)
        self.view.addSubview(paymentSuccessView!)
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
