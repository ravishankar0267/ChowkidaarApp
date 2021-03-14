//
//  PaymentSuccessView.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 5/2/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class PaymentSuccessView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var PaymentID: UILabel!
    @IBOutlet weak var paymentSuccessText: UILabel!
    @IBOutlet weak var paymentSuccessBGView: UIView!
    override init(frame: CGRect) {
           super.init(frame: frame)
           //nibSetup()
       }
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
         //  nibSetup()
       }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
