//
//  CallusTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 25/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class CallusTableViewCell: UITableViewCell {
    @IBOutlet weak var callUsLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var buttonLabel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUIData() {
           
          
//          callUsLabel.text = DataModel.nameText
//              //itemList.message
//          emailIdLabel.text = DataModel.mobileNumber
//              //itemList.subMessage
//        
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // your code here
                self.backgroundCellView.setCornerRadius(value: 10)
                self.backgroundCellView.backgroundColor = .white
                self.backgroundCellView.setShadow(color: .lightGray, offset: .zero, opacity: 0.9, radius: 7)
            }
           
        }
    
}
