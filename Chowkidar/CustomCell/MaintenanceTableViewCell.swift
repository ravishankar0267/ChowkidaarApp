//
//  MaintenanceTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 3/2/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class MaintenanceTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCellView: UIView!
    
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var invoiceAmountLabel: UILabel!
    
    @IBOutlet weak var invoicePayDate: UILabel!
    @IBOutlet weak var invoiceGeneratedDate: UILabel!
    @IBOutlet weak var payNowButton: UIButton!
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
                   self.payNowButton.setCornerRadius(value: 5)
                //self.profilePicImageVw.setCornerRadiusImageView(value: 27)
               }
              
           }
    
}
