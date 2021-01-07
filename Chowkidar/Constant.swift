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

//Tab Menu
let homeTabOptions = ["Home", "My Bookings", "Account", "Messaging"]
let homeTabDefaultImage = ["home_tab_unselected", "booking_tab_unselected", "account_tab_unselected", "messaging_tab_unselected"]
let homeTabSelectedImage = ["home_tab_selected", "booking_tab_selected", "account_tab_selected", "messaging_tab_selected"]

//Drawer Menu
let drawerOptions = ["Emergency Contacts", "About Us", "Explore"]
let drawerImages = ["emergencyContacts", "aboutUs", "aboutUs"]

//Home Menu
let homeOptions = ["My trip Itinerary", "Travel Documents", "Trip Feedback", "Travel Utilities", "Recommended Holidays", "Refer & Earn"]
let homeOptionsImages = ["trip_itinerary", "trav_documents", "trip_feedback", "travel_utilities", "recommended_holidays", "refer_and_earn"]

//Travel doc Menu
let travelDocOptions = ["Passport", "Visa", "Pan Card", "Voter Id Card", "Frequent Filer No.", "Aadhar Card"]
let travelDocOptionsImages = ["passport", "visa", "pancard", "voter_id", "frequent", "aadhar"]

//Travel utility Menu
let travelUtilityOptions = ["Currency Convertor", "Weather", "Passport Enquiry Tracker", "long Weekend calancer"]
let travelUtilityOptionsImages = ["Currency Convertor", "Weather", "Passport Enquiry Tracker", "long Weekend calancer"]

enum TravelDocSection: String {
    case passport = "PASSPORT"
    case visa = "VISA"
    case panCard = "PAN"
    case voterIdCard = "VOTER ID"
    case frequentFilerNo = "FREQUENT FILER NO."
    case aadhar = "AADHAR"
}

//Trip feedback Menu
let tripFeddbackOptions = ["RATINGS", "EXPERIENCE", "PICTURES"]
let tripFeddbackImageOptions = ["star_yellow", "experience_trip", "pictures"]
let tripFeddbackDescriptionOptions = ["Please rate your trip.", "Share your experience and help us to serve you better in future.", "Post pictures and share wonderful memories of your trip."]

// My Profile
let profileSectionOptions = ["  MY PROFILE  ", "  HOLIDAY PREFERANCE  ", "  ACCOMODATION PREFERANCE  ", "  MEAL PREFERANCE  ", "  SPECIAL ASSISTANCE  "]
let myProfileItems = ["Name", "Mobile No.", "Alternate Mobile No.", "Email Address", "Alternate Email Address", "D.O.B", "Anniversary Date", "Address"]
let myProfileItemsImages = ["person", "phone", "phone", "mail", "mail", "dob", "calendar", "location"]

// Refer
let referEarnOptions = ["Referral Name", "Relation", "Mobile Number", "City", "Martial Status", "Profession", "Email"]


// Constant
///Login
let kIsLoggedIn = "isLogggedin"
let kLoginOTP = "loginOTP"
let kLoginMobileNumber = "loginMobileNumber"
let kLoginType = "loginType"
let kLoginID = "loginID"



//MARK: API CONSTANTS
let requestFailureError = "Status code 500: server internal error"
let kProductionURl = ""
let kLiveURL = ""
let kBASE_URL = "https://flat-project-278107.df.r.appspot.com/flatowner/sendSMS"

let URL_Registration = "json_clientregistration.php?" //firstName=aamir&lastName=ahmed&birthDate=1994-12-23&address1=saharanpur&email=aamirahmed620gmail.com&phoneNo=8130220538
let URL_SendSMS = "sendSMS" //mobile=8130220538
let URL_ForgotOTP = "json_forgototp.php?" //id=671
let URL_Profile = "json_clientprofile.php?" //id=671
let URL_UpdateProfile = "json_updateprofile.php?" //id=671&firstName=aamir&lastName=ahmed&birthDate=1994-12-23&anniversaryDate=2020-12-20&address1=saharanpur&email=aamirahmed620gmail.com&phoneNo=8130220538
let URL_ItineraryDays = "json_itenerarydays.php?" //id=671&type=2
let URL_VoterID = "json_voteriddetails.php?" //id=671&type=2
let URL_Aadhar = "json_aadhardetails.php?" //id=671&type=2
let URL_PastTrip = "json_pasttrips.php?" //id=343&type=2
let URL_Passport = "json_passportdetails.php?" //id=671&type=2
