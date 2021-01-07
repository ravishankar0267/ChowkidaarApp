//
//  DrawerTableViewCell.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 13/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class DrawerTableViewCell: UITableViewCell {

    @IBOutlet weak var aTitleLabel: UILabel!
    @IBOutlet weak var aImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aImageView.setCornerRadiusImageView(value: 5)
    }

    func setupUIData(title: String, imageName: String) {
        aTitleLabel.text = title
        aImageView.image = UIImage(named: imageName)
    }
    
}
