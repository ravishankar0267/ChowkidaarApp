//
//  Constant.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import Foundation
import UIKit

// MARK: DEVICE RELATED STUFF

enum UIUserInterfaceIdiom: Int {
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_OR_GREATER = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1024.0
}

let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString

//Tab Menu
let homeTabOptions = ["Home", "My Bookings", "Account", "Messaging"]
let homeTabDefaultImage = ["home_tab_unselected", "booking_tab_unselected", "account_tab_unselected", "messaging_tab_unselected"]
let homeTabSelectedImage = ["home_tab_selected", "booking_tab_selected", "account_tab_selected", "messaging_tab_selected"]

//Drawer Menu
let drawerOptions = ["Emergency Contacts", "About Us", "Explore"]
let drawerImages = ["emergencyContacts", "aboutUs", "aboutUs"]

// Constant
///

let kIsLoggedIn = "isLogggedin"
let kLoginOTP = "loginOTP"
let kLoginMobileNumber = "loginMobileNumber"
let kAccessId = "accessId"
let kUserID = "userId"
let kComplexID = "complexId"
let kFaltNo = "flatNumber"
let kWing = "wing"



//MARK: API CONSTANTS
//MARK: API CONSTANTS
let requestFailureError = "Status code 500: server internal error"
let kProductionURl = ""
let kLiveURL = ""
let kBASE_URL = "https://flat-project-278107.df.r.appspot.com/"
//"https://qa-api.chowkidar.co/"
let kSendSMS = "flatowner/sendSMS"
let kVerifySMS = "flatowner/verifySms"
let kRegsiterToken = "flatowner/registerToken"
let kGetOwnersFlat = "flatowner/getOwnerFlats"
let KFetchProfile = "flatowner/FetchProfile"
let kGetUserDashboardData = "flatowner/getUserDashboardData"
let kUpdateProfile = "flatowner/updateProfile"
let kgetExternalComplexEmployee   = "employee/getExternalComplexEmployees"
let kgetMyExternalComplexEmployee   = "/employee/geMyExternalComplexEmployees"

