//
//  DataModel.swift
//  Chowkidar
//
//  Created by Ravi Mishra on 16/1/21.
//  Copyright © 2021 Ravi Mishra. All rights reserved.

import Foundation

//"accessId" : 500,
//          "userId" : 500,
//          "complexId" : 700,
//          "flatNumber" : "201",
//          "wing" : "A"

// MARK: - ItineraryDataModelElement
struct onwersFlatDataModelElement: Codable {
    let id: String?
    let userID, v, complexID: Int?
    let complexName: String?
    let flatNumber, wing: String?
    let isTenant, isEnable, isVisibleToEverybody: Bool?
    let complex: Complex?
    let isAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case v = "__v"
        case complexID = "complexId"
        case complexName, flatNumber, wing, isTenant, isEnable, isVisibleToEverybody, complex, isAdmin
    }
}

// MARK: - Complex
struct Complex: Codable {
    let id: String?
    let complexID: Int?
    let name: String?
    let v: Int?
    let address: Address?
    let emailIDS: [String]?
    let facility: [Facility]?
    let imageUrls: [String]?
    let noOfGate: Int?
    let partyHalls: [PartyHall]?
    let phones: [Int]?
    let updatedTime: UpdatedTime?
    let websiteURL: String?
    let wings: [Wing]?
    let startDate, endDate: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case complexID = "complexId"
        case name
        case v = "__v"
        case address
        case emailIDS = "emailIds"
        case facility, imageUrls, noOfGate, partyHalls, phones, updatedTime
        case websiteURL = "websiteUrl"
        case wings, startDate, endDate
    }
}

// MARK: - Address
struct Address: Codable {
    let latlng: [JSONAny]?
    let city, state: String?
    let area: String?
    let street: String?
    let pinCode: Int?
}

// MARK: - Facility
struct Facility: Codable {
    let id: String?
    let count, ftype: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case count, ftype
    }
}

// MARK: - PartyHall
struct PartyHall: Codable {
    let id, hallName: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hallName
    }
}

enum UpdatedTime: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(UpdatedTime.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for UpdatedTime"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Wing
struct Wing: Codable {
    let id, label: String?
    let floor, start, end: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case label, floor, start, end
    }
}

typealias OwnersFlatDataModel = [onwersFlatDataModelElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}


struct SendSMSDataModel: Codable {
    let message: String?
}

struct VerifySMSDataModel: Codable {
    let message: String?
    let token: String?
    let userId: Int?
}

struct RegsiterTokenDataModel: Codable {
    let message: String?
}

// MARK: - Dashboard Data model
struct DashboardDataModel: Codable {
    let flatInfo: FlatInfo?
    let itemList: [ItemList]?
    let imageList: [ImageList]?
}

// MARK: - FlatInfo
struct FlatInfo: Codable {
    let isVisibleToEverybody: Bool?
    let id: String?
    let userID, v, complexID: Int?
    let complexName, flatNumber, wing: String?
    let isTenant, isEnable: Bool?

    enum CodingKeys: String, CodingKey {
        case isVisibleToEverybody
        case id = "_id"
        case userID = "userId"
        case v = "__v"
        case complexID = "complexId"
        case complexName, flatNumber, wing, isTenant, isEnable
    }
}

// MARK: - ImageList
struct ImageList: Codable {
    let typeID: Int?
    let image, deepLink: String?

    enum CodingKeys: String, CodingKey {
        case typeID = "typeId"
        case image, deepLink
    }
}

// MARK: - ItemList
struct ItemList: Codable {
    let typeID: Int?
    let title, message, subMessage, buttonText: String?
    let isButtonVisible: Bool?
    let deepLink, buttonDeepLink: String?

    enum CodingKeys: String, CodingKey {
        case typeID = "typeId"
        case title, message, subMessage, buttonText, isButtonVisible, deepLink, buttonDeepLink
    }
}


// MARK: - User profile data model
struct UserProfileDataModel: Codable {
    let mobileNumber: String?
    let userID: Int?
    let deviceToken, dob: String?
    let dobDate: Int?
    let emailID: String?
    let gender: Int?
    let genderName: String?
    let image: String?
    let name: String?
    let permanentAddress: String?
    let professionID: Int?
    let isSuperAdmin: Bool?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case mobileNumber
        case userID = "userId"
        case deviceToken, dob, dobDate
        case emailID = "emailId"
        case gender, genderName, image, name, permanentAddress
        case professionID = "professionId"
        case isSuperAdmin, imageURL
    }
}

struct EmergencyContactsDataModel: Codable {
let nameText:String?
let mobileNumber: String?
}

struct  updateProfileDataModel: Codable {
    let status, userID: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case userID = "userId"
        case message
    }
}


// MARK: - AllServiceModelElement


struct AllServiceDataModel: Codable {
    var id: String?
    var flatOwners: FlatOwners?
    var isComplexEmployee, isActive: Bool?
    var name, mobileNumber: String?
    var gender: Int?
    var genderName: String?
    var exp, identityType: Int?
    var identityTypeName, currentAddress: String?
    var complexID, serviceType: Int?
    var serviceTypeName: String?
    var pinNumber, salary, createdDate, employeeID: Int?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case flatOwners, isComplexEmployee, isActive, name, mobileNumber, gender, genderName, exp, identityType, identityTypeName, currentAddress
        case complexID = "complexId"
        case serviceType, serviceTypeName, pinNumber, salary, createdDate
        case employeeID = "employeeId"
        case v = "__v"
    }
}

// MARK: - FlatOwners
struct FlatOwners: Codable {
    var accessID, complexID: Int?
    var flatNumber: String?
    var userID: Int?
    var wing: String?

    enum CodingKeys: String, CodingKey {
        case accessID = "accessId"
        case complexID = "complexId"
        case flatNumber
        case userID = "userId"
        case wing
    }
}
typealias AllServiceModel = [AllServiceDataModel]

// MARK: - MyHelpersDataModelElement
struct MyHelpersDataModelElement: Codable {
    let id: String
    let flatOwners: FlatOwners
    let isComplexEmployee, isActive: Bool
    let name, mobileNumber: String
    let gender: Int
    let genderName: String
    let exp, identityType: Int
    let identityTypeName, currentAddress: String
    let complexID, serviceType: Int
    let serviceTypeName: String
    let pinNumber, salary, createdDate, employeeID: Int
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case flatOwners, isComplexEmployee, isActive, name, mobileNumber, gender, genderName, exp, identityType, identityTypeName, currentAddress
        case complexID = "complexId"
        case serviceType, serviceTypeName, pinNumber, salary, createdDate
        case employeeID = "employeeId"
        case v = "__v"
    }
}

typealias MyHelpersDataModel = [AllServiceDataModel]
