//
//  HomeViewController.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.

import UIKit
import Alamofire

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var aCollectionView: UICollectionView!
    
   // var profileDataModel: ProfileDataModel?
    var drawerView: DrawerView?
    var dashboardDataModel:DashboardDataModel?
    var userDataModel:UserProfileDataModel?
    var buttonSelectionTap = DashboardButtonSelection.bookHall
    
    @IBOutlet weak var dashboardTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDashboardData()
        
        dashboardTableView.register(UINib(nibName: DashBoardTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: DashBoardTableViewCell.identifier())
        
          dashboardTableView.rowHeight = UITableView.automaticDimension
         dashboardTableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addHomeNavigationBar()
        getProfileData()
    }
    
    func fetchDashboardData()  {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        let params: [String: Any] = [
            "accessId" : UserDefaults.standard.value(forKey: kAccessId) ?? "",
            "userId" :  UserDefaults.standard.value(forKey: kUserID) ?? "",
            "complexId" :  UserDefaults.standard.value(forKey: kComplexID) ?? "" ,
            "flatNumber" :  UserDefaults.standard.value(forKey: kFaltNo) as! String,
            "wing" :  UserDefaults.standard.value(forKey: kWing) as! String
        ]
        self.showActivityIndicator(sMessage: "Fetching Dashboard data")
        NetworkManager.post_Request(urlService: kGetUserDashboardData, param: params, head: headers, responseType: DashboardDataModel.self) { (response, statusCode) in
            if response != nil {
                self.hideActivityIndicator()
                guard let responseData = response as? DashboardDataModel else {
                    return
                }
              
                if statusCode == 200 {
                    Loader.showToast(message: "Recieved dashboard data" , onView: self.view, bottomMargin: 200)
                    self.dashboardDataModel = responseData
                    self.dashboardTableView.reloadData()
                } else {
                    Loader.showAlert(message: "Unable to fetch dashboard data" )
                }
            }
        }
    }
    
    override func handleMenuButtonAction() {
        openDrawerView()
    }
    
    override func handleNotificationButtonAction() {
        // openAlertsVC()
    }
    
    func openDrawerView() {
        getProfileData()
        if drawerView == nil {
            drawerView = Bundle.main.loadNibNamed("DrawerView", owner: self, options: nil)?.first as? DrawerView
            drawerView?.frame = CGRect(x: -ScreenSize.SCREEN_WIDTH, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
            APP_DEL.window?.addSubview(drawerView!)
            drawerView?.setCloseButtonBackgroundColor(color: .clear)
            drawerView?.profileData = userDataModel
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
    
    
    func getProfileData() {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]
        
        let params: [String: Any] = [
            "accessId" : 500,
            "userId" : 500,
        ]
        
        NetworkManager.post_Request(urlService: KFetchProfile, param: params, head: headers, responseType: UserProfileDataModel.self) { (response, statusCode) in
            if response != nil {
                guard let responseData = response as? UserProfileDataModel else {
                    return
                }
                if statusCode == 200 {
                    print("Profile Response ===", responseData)
                    Loader.showToast(message: "responseData.complexName" , onView: self.view, bottomMargin: 200)
                    self.userDataModel = responseData
                } else {
                    Loader.showAlert(message: "responseData.complexName" )
                }
            }
        }
    }
    
    func cellButtonClickAction(sender:UIButton)  {
        switch sender.tag {
        case DashboardButtonSelection.payNow.rawValue:
            print("payNow Clicked")
            break
        case DashboardButtonSelection.viewHelper.rawValue:
            print("viewHelper Clicked")
            break
        case DashboardButtonSelection.bookHall.rawValue:
            print("Book Hall Clicked")
            break
        case DashboardButtonSelection.inviteVisitor.rawValue:
            print("inviteVisitor Clicked")
            break
        case DashboardButtonSelection.addTickets.rawValue:
            print("addTickets Clicked")
            break
        default:
            break
        }
    }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardDataModel?.itemList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashBoardTableViewCell.identifier(), for: indexPath) as! DashBoardTableViewCell
        cell.setupUIData(itemList: dashboardDataModel!.itemList?[indexPath.row] )
        cell.tableCellButtonCompletionBlock = {btn -> Void in
        weak var weakSelf : HomeViewController? = self
                   if let strongself = weakSelf
                   {
                    strongself.cellButtonClickAction(sender: btn)
                   }
               }
        return cell
        
    }
    
    
    
        func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0){
        openViewController(controller: MaintenanceViewController.self, storyBoard: .mainStoryBoard) { (vc) in
            
        }}
        else {
            openViewController(controller: ServicesViewController.self, storyBoard: .mainStoryBoard) { (vc) in
                
            }
            
        }
    }
    
}

