//
//  HomeViewController.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 13/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var aCollectionView: UICollectionView!
    
    var profileDataModel: ProfileDataModel?
    var drawerView: DrawerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // aCollectionView.register(UINib(nibName: TravItemCVCell.identifier(), bundle: nil), forCellWithReuseIdentifier: TravItemCVCell.identifier())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addHomeNavigationBar()
        getProfileData()
    }
    
    override func handleMenuButtonAction() {
        openDrawerView()
    }
    
    override func handleNotificationButtonAction() {
       // openAlertsVC()
    }
    
    func openDrawerView() {
        if drawerView == nil {
            drawerView = Bundle.main.loadNibNamed("DrawerView", owner: self, options: nil)?.first as? DrawerView
            drawerView?.frame = CGRect(x: -ScreenSize.SCREEN_WIDTH, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(drawerView!)
            if let profileInfo = self.profileDataModel {
                if let profileResult = profileInfo.results {
                    if profileResult.count > 0 {
                        drawerView?.profileData = profileResult[0]
                    }
                }
            }
            drawerView?.setCloseButtonBackgroundColor(color: .clear)
            UIView.animate(withDuration: 0.5, animations: {
                self.drawerView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            }) { (true) in
                self.drawerView?.setCloseButtonBackgroundColor(color: UIColor(red: 67 / 255, green: 67 / 255, blue: 67 / 255, alpha: 0.7))
            }
            drawerView?.closeActionClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.closeDrawerView()
                }
            }
            drawerView?.emergencyContactsActionClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.openEmergencyContactsVC()
                }
            }
            drawerView?.myProfileActionClouser = { [weak self] isFromDrawerEdit in
                if let strongSelf = self {
                    strongSelf.openMyProfileVC(isDrawerEditAction: isFromDrawerEdit)
                }
            }
            drawerView?.aboutUsActionClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.openAboutUsVC()
                }
            }
            drawerView?.exploreActionClouser = { [weak self] in
                if let strongSelf = self {
                    strongSelf.openExploreVC()
                }
            }
//            drawerView?.messagingActionClouser = { [weak self] in
//                if let strongSelf = self {
//                    strongSelf.openMessagingVC()
//                }
//            }
            drawerView?.logoutActionClouser = {[weak self] in
                if let strongSelf = self {
                    strongSelf.logoutAction()
                }
            }
        }
    }
    
    fileprivate func closeDrawerView() {
        drawerView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
        self.drawerView?.setCloseButtonBackgroundColor(color: .clear)
        UIView.animate(withDuration: 0.5, animations: {
            self.drawerView?.frame = CGRect(x: -ScreenSize.SCREEN_WIDTH, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
        }) { (true) in
            self.drawerView?.removeFromSuperview()
            self.drawerView = nil
        }
    }
    
    func logoutAction() {
        let alert = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: { (action) in
            UserDefaults.standard.set(false, forKey: kIsLoggedIn)
            UserDefaults.standard.synchronize()
            APP_DEL.openInitialViewController()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openEmergencyContactsVC() {
        openViewController(controller: EmergencyContactsViewController.self, storyBoard: .emergencyContactsStoryBoard) { (vc) in
            
        }
    }
    
    func openAboutUsVC() {
        openViewController(controller: AboutUsViewController.self, storyBoard: .aboutUsStoryBoard) { (vc) in
            
        }
    }
    
    func openExploreVC() {
        openViewController(controller: ExploreViewController.self, storyBoard: .exploreStoryBoard) { (vc) in
            
        }
    }
//
    func openMyProfileVC(isDrawerEditAction: Bool) {
        openViewController(controller: EditProfileViewController.self, storyBoard: .editProfile) { (vc) in
//            vc.isFromDrawerEditAction = isDrawerEditAction
//            if let profileInfo = self.profileDataModel {
//                if let profileResult = profileInfo.results {
//                    if profileResult.count > 0 {
//                        vc.profileData = profileResult[0]
//                    }
                }
            }
       // }
   // }

//    func openAlertsVC() {
//        openViewController(controller: AlertViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openMyTripVC() {
//        openViewController(controller: MyBookingViewController.self, storyBoard: .myBookingsStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openMessagingVC() {
//        openViewController(controller: MessagingViewController.self, storyBoard: .messagingStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openTripFeedbackVC() {
//        openViewController(controller: TripFeedbackViewController.self, storyBoard: .travelStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openTripUtilityVC() {
//        openViewController(controller: TripUtilitiesViewController.self, storyBoard: .travelStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openHolidayVC() {
//        openViewController(controller: HolidayViewController.self, storyBoard: .travelStoryBoard) { (vc) in
//
//        }
//    }
//
//    func openReferEarnVC() {
//        openViewController(controller: ReferEarnViewController.self, storyBoard: .homeStoryBoard) { (vc) in
//
//        }
//    }
    
    func getProfileData() {
        if let userID = UserDefaults.standard.value(forKey: kLoginID) as? String {
            NetworkManager.generateURLWithQueryParam(baseURL: kBASE_URL, componentURL: URL_Profile, queryItems: [URLQueryItem.init(name: "id", value: userID)]) { (responseURL) in
                if let finalURL = responseURL as? URL {
                    NetworkManager.get_Request(requestURL: finalURL) { (response) in
                        do {
                            if response != nil {
                                let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                                let responseModel = try JSONDecoder().decode(ProfileDataModel.self, from: responseData)
                                self.profileDataModel = responseModel
                            }
                        } catch {
                            Loader.showAlert(message: requestFailureError)
                        }
                    }
                }
            }
        }
    }
}

