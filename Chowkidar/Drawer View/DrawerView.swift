//
//  DrawerView.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 13/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class DrawerView: UIView {

    @IBOutlet weak var aCloseButton: UIButton!
    @IBOutlet weak var aEditProfileButton: UIButton!
    @IBOutlet weak var aAccountNameLabel: UILabel!
    @IBOutlet weak var aProfilePicImageView: UIImageView!
    @IBOutlet weak var aTableView: UITableView!
    
    var closeActionClouser: (() -> Void) = { }
    var emergencyContactsActionClouser: (() -> Void) = { }
    var aboutUsActionClouser: (() -> Void) = { }
    var exploreActionClouser: (() -> Void) = { }
    var myProfileActionClouser: ((Bool) -> Void) = { _ in}
    var messagingActionClouser: (() -> Void) = { }
    var logoutActionClouser: (() -> Void) = { }
    var profileData: ProfileDataResult? {
        didSet {
            updateProfileData()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        aTableView.register(UINib(nibName: DrawerTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: DrawerTableViewCell.identifier())
       // aEditProfileButton.setCornerRadiusButton(value: 15)
        aProfilePicImageView.setCornerRadiusImageView(value: 42.5)
    }
    
    func setCloseButtonBackgroundColor(color: UIColor) {
        aCloseButton.backgroundColor = color
    }
    
    @IBAction func editProfileButtonAction(_ sender: UIButton) {
        closeActionClouser()
        myProfileActionClouser(true)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        closeActionClouser()
    }
    
    func updateProfileData() {
        if let profileInfo = profileData {
            if let name = profileInfo.name {
                aAccountNameLabel.text = name.capitalized
            }
        }
    }
}

extension DrawerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawerOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DrawerTableViewCell.identifier(), for: indexPath) as! DrawerTableViewCell
        cell.setupUIData(title: drawerOptions[indexPath.row], imageName: drawerImages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeActionClouser()
        switch indexPath.row {
        case 0: // My trip Itinerary
            emergencyContactsActionClouser()
        case 1: // Travel Documents
            aboutUsActionClouser()
        case 2: // Alerts
            exploreActionClouser()
        default:
            break
        }
    }
}
