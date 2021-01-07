//
//  NavigationBarView.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit

class NavigationBarView: UIView {

    @IBOutlet weak private var aLeftTitleLabel: UILabel!
    @IBOutlet weak private var aBackButton: UIButton!
    
    weak var baseControllerObj: BaseViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aBackButton.isExclusiveTouch = true
    }
    
    func setNavigtionTitle(title: String) {
        aLeftTitleLabel.text = title
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        baseControllerObj?.handleBackButtonAction()
    }

}
