//
//  BookHallTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 25/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class BookHallTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cancelBookingButton: UIButton!
    
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var AmountDetailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUIData() {
          
//           venueLabel.text = itemList.title
//           eventLabel.text = itemList.message
//           dateLabel.text = itemList.subMessage
           //cancelBookingButton.setTitle("", for: UIControl.State.normal)
        //cancelBookingButton.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        buttonHeightConstraint.constant = 0
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               // your code here
               self.backgroundCellView.setCornerRadius(value: 10)
               self.backgroundCellView.backgroundColor = .white
               self.backgroundCellView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
//               self.mButton.setCornerRadius(value: 5)
           }
          
       }
    
}
