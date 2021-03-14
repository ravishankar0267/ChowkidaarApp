//
//  DrawerTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.

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
