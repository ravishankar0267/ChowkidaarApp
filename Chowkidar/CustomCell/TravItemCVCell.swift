//
//  TravItemCVCell.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 26/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class TravItemCVCell: UICollectionViewCell {

    @IBOutlet weak var aImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImageView(imageName: String) {
        aImageView.image = UIImage(named: imageName)
    }
}
