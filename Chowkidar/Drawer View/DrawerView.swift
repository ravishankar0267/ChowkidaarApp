//
//  DrawerView.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.
//

import UIKit

class DrawerView: UIView {
    
    @IBOutlet weak var aCloseButton: UIButton!
    @IBOutlet weak var aEditProfileButton: UIButton!
    @IBOutlet weak var aAccountNameLabel: UILabel!
    @IBOutlet weak var aProfilePicImageView: UIImageView!
    @IBOutlet weak var aTableView: UITableView!
    
    @IBOutlet weak var addressLine1: UILabel!
    @IBOutlet weak var generValueLabel: UILabel!
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var emailIdLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    var closeActionClouser: (() -> Void) = { }
    var emergencyContactsActionClouser: (() -> Void) = { }
    var aboutUsActionClouser: (() -> Void) = { }
    var exploreActionClouser: (() -> Void) = { }
    var myProfileActionClouser: ((Bool) -> Void) = { _ in}
    var messagingActionClouser: (() -> Void) = { }
    var logoutActionClouser: (() -> Void) = { }
    var profileData: UserProfileDataModel? {
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
        menuHeightConstraint.constant = 375
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
            if let name = profileInfo.name{
                aAccountNameLabel.text = name
            }else{ aAccountNameLabel.text = ""}
            if let gender = profileInfo.genderName{
                generValueLabel.text = gender
            }else{ generValueLabel.text = ""}
            if let addressPermanent = profileInfo.permanentAddress{
                addressLine1.text = addressPermanent
            }else{ addressLine1.text = ""}
            if let emailID = profileInfo.emailID{
                emailIdLabel.text = emailID
            }else{ emailIdLabel.text = ""}
            if let dateofBirth = profileInfo.dobDate{
                dateOfBirthLabel.text = String(dateofBirth)
            }else{ dateOfBirthLabel.text = ""}
            if let IDNumber = profileInfo.professionID{
                idNumberLabel.text = String(IDNumber)
            }else{ idNumberLabel.text = ""}
            if let profilePicURLString = profileInfo.imageURL{
                let profilePicURL = URL(string: profilePicURLString)
                    //URL(with: profilePicURLString)
                self.downloadImage(from: profilePicURL!)
                       }else{ idNumberLabel.text = ""}
            
        }
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.aProfilePicImageView.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
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
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeActionClouser()
        switch indexPath.row {
        case 0: // emergency contacts
            emergencyContactsActionClouser()
        case 1: // About us
            aboutUsActionClouser()
        case 2: // Explore
            exploreActionClouser()
        default:
            break
        }
    }
}
