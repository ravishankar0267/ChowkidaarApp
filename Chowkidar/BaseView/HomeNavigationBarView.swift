//
//  HomeNavigationBarView.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit

class HomeNavigationBarView: UIView {

    @IBOutlet weak private var aMenuButton: UIButton!
    @IBOutlet weak private var aNotificationButton: UIButton!
    
    weak var baseControllerObj: BaseViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aNotificationButton.isExclusiveTouch = true
        aMenuButton.isExclusiveTouch = true
    }

    @IBAction func notificationButtonAction(_ sender: UIButton) {
        baseControllerObj?.handleNotificationButtonAction()
    }
    
    @IBAction func menuButtonAction(_ sender: UIButton) {
        baseControllerObj?.handleMenuButtonAction()
    }

}
