//
//  ServicesTableViewCell.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 31/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {
    @IBOutlet weak var backgroundCellView: UIView!
    
    @IBOutlet weak var addServiceButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var profilePicImageVw: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var SalaryLabel: UILabel!
    @IBOutlet weak var addServiceButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    typealias resetCompletionHandler = (_ buttonText:String)->Void
    typealias callCompletionHandler = ()->Void
     var resetCompletionBlock : resetCompletionHandler?
     var callCompletionBlock : callCompletionHandler?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUIData(isAllServiceSelected:Bool, allServiceDataModel:AllServiceDataModel) {
        if(!isAllServiceSelected){
            addServiceButtonHeightConstraint.constant = 0
        }
        else {
            addServiceButtonHeightConstraint.constant = 30
        }
        if let nameText = allServiceDataModel.name{
          nameLabel.text = nameText
        } else{nameLabel.text = ""}
        if let occupationText = allServiceDataModel.serviceTypeName{
          occupationLabel.text = occupationText
        } else{occupationLabel.text = ""}
        if let salaryText = allServiceDataModel.salary{
            SalaryLabel.text = String(salaryText)
        }else{SalaryLabel.text  = ""}
        
        if(allServiceDataModel.isActive!){
           addServiceButton.setTitle(" Remove service ", for: UIControl.State.normal)
        } else{
           addServiceButton.setTitle(" Add service ", for: UIControl.State.normal)
        }
               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   // your code here
                   self.backgroundCellView.setCornerRadius(value: 10)
                   self.backgroundCellView.backgroundColor = .white
                   self.backgroundCellView.setShadow(color: .gray, offset: .zero, opacity: 0.7, radius: 5)
                   self.addServiceButton.setCornerRadius(value: 5)
                self.profilePicImageVw.setCornerRadiusImageView(value: 27)
               }
              
           }
    
    @IBAction func callButtonAction(_ sender: UIButton) {
        if(callCompletionBlock != nil){
                         callCompletionBlock!()
                     }
        
    }
    @IBAction func addRemoveService(_ sender: UIButton) {
        let ButtonText = sender.titleLabel?.text
        if(resetCompletionBlock != nil){
                   resetCompletionBlock!(ButtonText!)
               }
    }
}
