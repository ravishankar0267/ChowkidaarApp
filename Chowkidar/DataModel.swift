//
//  DataModel.swift
//  TravCRM
//
//  Created by Sudhanshu Gupta on 12/04/20.
//  Copyright © 2020 iDev. All rights reserved.
//

import Foundation

// MARK: - LoginDataModel
struct LoginDataModel: Codable {
    let status: String?
    let results: [LoginDataResult]?
}

// MARK: - LoginDataResult
struct LoginDataResult: Codable {
    let mobile, id, type, otp, error: String?
}

// MARK: - ProfileDataModel
struct ProfileDataModel: Codable {
    let status: String?
    let results: [ProfileDataResult]?
}

// MARK: - ProfileDataResult
struct ProfileDataResult: Codable {
    let name, country, mobile, email: String?
    let dob, anniversaryDate, address: String?
}

// MARK: - VoterIDDataModel
struct VoterIDDataModel: Codable {
    let status: String?
    let results: [VoterIDResult]?
}

// MARK: - VoterIDResult
struct VoterIDResult: Codable {
    let id, clientName, documentType, documentNo: String?
    let country, issueDate, expiryDate: String?
}

// MARK: - PassportDataModel
struct PassportDataModel: Codable {
    let status: String?
    let results: [PassportResult]?
}

// MARK: - PassportResult
struct PassportResult: Codable {
    let id, clientName, documentType, documentNo: String?
    let country, issueDate, expiryDate: String?
}

// MARK: - AadharDataModel
struct AadharDataModel: Codable {
    let status: String?
    let results: [AadharResult]?
}

// MARK: - AadharResult
struct AadharResult: Codable {
    let id, clientName, documentType, documentNo: String?
    let country, issueDate, expiryDate: String?
}

// MARK: - ItineraryDataModel
struct ItineraryDataModel: Codable {
    let status: String
    let results: [ItineraryResult]
}

// MARK: - ItineraryResult
struct ItineraryResult: Codable {
    let id, date, day, destination: String
    let image1: String
    let hotelname, hotelcategory, roomtype, mealplan: String
    let veimage2: String
    let vetransferName, vetype, vename, vemaxpax: String
    let vestarttime, veendtime, vetransferDetail, images3: String
    let enrouteName, enrouteDetail, images4, entranceName: String
    let entranceDetail: String
    let images5: String
    let otherActivityName, otherActivityDetail, flightName, flightNumber: String
    let flightClass, departure, arrival, trainName: String
    let trainNumber, trainClass, trainDeparture, trainArrival: String

    enum CodingKeys: String, CodingKey {
        case id, date, day, destination, image1, hotelname, hotelcategory, roomtype, mealplan, veimage2, vetransferName, vetype, vename, vemaxpax, vestarttime, veendtime, vetransferDetail
        case images3 = "Images3"
        case enrouteName, enrouteDetail
        case images4 = "Images4"
        case entranceName, entranceDetail
        case images5 = "Images5"
        case otherActivityName, otherActivityDetail, flightName, flightNumber, flightClass, departure, arrival, trainName, trainNumber, trainClass, trainDeparture, trainArrival
    }
}
