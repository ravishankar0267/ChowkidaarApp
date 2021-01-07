//
//  Connectivity.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
