//
//  MyFlatsTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 30/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class MyFlatsTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var apartmentNameLabel: UILabel!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var wingNoLabel: UILabel!
    @IBOutlet weak var apartmentTypeLabel: UILabel!
    @IBOutlet weak var statusButtonAlbel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
       func setupUIData() {
       // apartmentNameLabel.text = "apartmentNameLabelsdcsdfcsdcscscscsdcsdsdsdsdsdsdsdc"
       // blockLabel.text = "sacdsvdfsxszfrfsaxszfdfsadsfdsfasfsdfsdf"
       // apartmentTypeLabel.text = "dcdffsdsdasdsasasasasaSasaSasaSasaS"
       // wingNoLabel.text = "dcdffsdsdasdsasasasasaSasaSasaSasaS"
    //           venueLabel.text = itemList.title
    //           eventLabel.text = itemList.message
    //           dateLabel.text = itemList.subMessage
               //cancelBookingButton.setTitle("", for: UIControl.State.normal)
            //cancelBookingButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
           // buttonHeightConstraint.constant = 0
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   // your code here
                   self.backgroundCellView.setCornerRadius(value: 10)
                   self.backgroundCellView.backgroundColor = .white
                   self.backgroundCellView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
    //               self.mButton.setCornerRadius(value: 5)
               }
              
           }
    
}
