//
//  DashBoardTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit


enum DashboardButtonSelection: Int {
    case payNow
    case viewHelper
    case bookHall
    case inviteVisitor
    case addTickets
}

class DashBoardTableViewCell: UITableViewCell {
    typealias tableCellButtonCompletionHandler = (_ button:UIButton)->Void
    var tableCellButtonCompletionBlock : tableCellButtonCompletionHandler?
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var maintenanceLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var submessageLabel: UILabel!
    var itemDataList:ItemList?
    
    @IBOutlet weak var mButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUIData(itemList:ItemList?) {
        guard let ItemData = itemList else {
            return
        }
        maintenanceLabel.text = ItemData.title
        messageLabel.text = ItemData.message
        submessageLabel.text = ItemData.subMessage
//        mButton. = " \(itemList.buttonText) "
        mButton.setTitle("  \(String(describing: ItemData.buttonText!))  ", for: UIControl.State.normal)
        if(ItemData.buttonText! == "Pay Now"){
            mButton.tag = DashboardButtonSelection.payNow.rawValue
        } else if(ItemData.buttonText! == "View"){
             mButton.tag = DashboardButtonSelection.viewHelper.rawValue
        } else if(ItemData.buttonText! == "Book"){
            mButton.tag = DashboardButtonSelection.bookHall.rawValue
        }else if(ItemData.buttonText! == "Invite Visitor"){
            mButton.tag = DashboardButtonSelection.inviteVisitor.rawValue
        }else if(ItemData.buttonText! == "Add Ticket"){
            mButton.tag = DashboardButtonSelection.addTickets.rawValue
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // your code here
            self.backgroundCellView.setCornerRadius(value: 10)
            self.backgroundCellView.backgroundColor = .white
            self.backgroundCellView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
            self.mButton.setCornerRadius(value: 7)
        }
       
    }
    

       
    @IBAction func CellButtonAction(_ sender: UIButton) {
         //let button = sender as! UIButton
        if(tableCellButtonCompletionBlock != nil){
            tableCellButtonCompletionBlock!(sender)
        }
    }
    
    
}
