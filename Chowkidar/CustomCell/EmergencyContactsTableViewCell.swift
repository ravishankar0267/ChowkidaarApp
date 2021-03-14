//
//  EmergencyContactsTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 24/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class EmergencyContactsTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var submessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUIData(DataModel:EmergencyContactsDataModel) {
         
        
        messageLabel.text = DataModel.nameText
            //itemList.message
        submessageLabel.text = DataModel.mobileNumber
            //itemList.subMessage
      
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              // your code here
              self.backgroundCellView.setCornerRadius(value: 10)
              self.backgroundCellView.backgroundColor = .white
              self.backgroundCellView.setShadow(color: .lightGray, offset: .zero, opacity: 0.9, radius: 7)
          }
         
      }
    
}
