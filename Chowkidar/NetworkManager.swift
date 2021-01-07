//
//  NetworkManager.swift
//  FantasyCricket
//
//  Created by Randhir Kumar on 14/05/19.
//  Copyright © 2019 Randhir Kumar. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class NetworkManager: NSObject {
    
    //MARK: Generate query URL
    class func generateURLWithQueryParam(baseURL: String, componentURL: String, queryItems: [URLQueryItem], completion: @escaping (_ anyObject: Any?) -> Void) {
        guard let baseURL = URL(string: baseURL + componentURL) else {
            completion(nil)
            return
        }
        guard var baseURLComponent = URLComponents.init(url: baseURL, resolvingAgainstBaseURL: false) else {
            completion(nil)
            return
        }
        baseURLComponent.queryItems?.append(contentsOf: queryItems)
        completion(baseURLComponent.url)
    }
    
    //MARK: Get
        class func get_Request(requestURL: URL, completion: @escaping (_ anyObject: Any?) -> Void) {
            if Connectivity.isConnectedToInternet {
                AF.request(requestURL, method: .get).validate().responseJSON { (response) in
                    guard response.error == nil else {
                        let errMsg = String(describing: response.error)
                        print(errMsg)
                        completion(nil)
                        return
                    }
                    guard response.response?.statusCode == 200 else {
                        completion(nil)
                        return
                    }
                    print("""
                        ------------------------------------------------------------------------------------------
                        Url = \(requestURL)
                        response.statusCode = \(String(describing: response.response?.statusCode))
                        errMsg = \(String(describing: response.error))
                        responseData = \(String(describing: response.result))
                        ------------------------------------------------------------------------------------------
                        """)
                    
                    switch response.result {
                    case .failure(_):
                        completion(nil)
                        return
                    case .success(let data):
                        completion(data)
                    }
                }
            } else {
                Loader.showAlert(message: "No Internet!")
            }
        }
    
//    class func get_Request(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
//        if Connectivity.isConnectedToInternet {
//            guard let urlString = URL(string: kBASE_URL + urlService) else {
//                completion(nil)
//                return
//            }
//            let parameter = param
//            let header = head
//            Alamofire.request(urlString, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    let errMsg = String(describing: response.result.error)
//                    print(errMsg)
//                    completion(nil)
//                    return
//                }
//                guard let responseData = response.result.value else {
//                    completion(nil)
//                    return
//                }
//                print("""
//                    ------------------------------------------------------------------------------------------
//                    Url = \(urlString)
//                    response.result.isSuccess = \(response.result.isSuccess)
//                    errMsg = \(String(describing: response.result.error))
//                    responseData = \(String(describing: response.result.value))
//                    ------------------------------------------------------------------------------------------
//                    """)
//                completion(responseData)
//            }
//        } else {
//            // Show Alert
//        }
//    }
    
    
//    //MARK: Post
//    class func post_Request(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
//        if Connectivity.isConnectedToInternet {
//            guard let urlString = URL(string: kBASE_URL + urlService) else {
//                completion(nil)
//                return
//            }
//            let parameter = param
//            let header = head
//            AF.request(urlString, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header).validate().responseJSON { (response) in
//                guard response.result.isSuccess else {
//                    let errMsg = String(describing: response.result.error)
//                    print(errMsg)
//                    completion(nil)
//                    return
//                }
//                guard let responseData = response.result.value else {
//                    completion(nil)
//                    return
//                }
//                print("""
//                    ------------------------------------------------------------------------------------------
//                    ******************************************************************************************
//                    ------------------------------------------------------------------------------------------
//                    Url = \(urlString)
//                    response.result.isSuccess = \(response.result.isSuccess)
//                    errMsg = \(String(describing: response.result.error))
//                    responseData = \(String(describing: response.result.value))
//                    ------------------------------------------------------------------------------------------
//                    ******************************************************************************************
//                    ------------------------------------------------------------------------------------------
//                    """)
//                completion(responseData)
//            }
//        } else {
//            Loader.showAlert(message: "No Internet Connection")
//        }
//    }
    
    
    /// Alamofilre:  Post request
    /// - Parameters:
    ///   - urlService: URL in String format for api call
    ///   - param: Parameters for api call
    ///   - head: Header for api call
    ///   - queryItems: Querry items for api call
    ///   - responseType: Response model tyle
    ///   - completion: A block to execute fpr api call response success ot failure
    
    class func post_Request<T: Codable>(urlService: String, param: [String : Any]?, head: HTTPHeaders?, queryItems: [URLQueryItem]? = nil, responseType: T.Type, completion: @escaping (_ anyObject: Any?) -> Void) {
        if Connectivity.isConnectedToInternet {
            var tempURL: URL?
            guard let urlString = URL(string: kBASE_URL + urlService) else {
                completion(nil)
                return
            }
            if let query = queryItems {
                guard var baseURLComponent = URLComponents.init(url: urlString, resolvingAgainstBaseURL: false) else {
                    completion(nil)
                    return
                }
                baseURLComponent.queryItems = query
                tempURL = baseURLComponent.url
            } else {
                tempURL = urlString
            }
            
            guard let apiURL = tempURL else {
                completion(nil)
                return
            }
            
            let parameter = param
            let header = head
            
            AF.request(apiURL, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
                .responseDecodable(of: T.self, queue: .main,completionHandler: { (response) in
                    
                    debugPrint("""
                        --------------------------------------------------------------------------------------
                        
                        Url = \(apiURL)
                        
                        response data = \(String(describing: response.data))
                        
                        errMsg = \(response.error.debugDescription)
                        
                        response = \(response.debugDescription)
                        
                        --------------------------------------------------------------------------------------
                        """)
                    
                    switch response.result {
                    case .success(let apiResponse):
                        completion(apiResponse)
                    case .failure(let error):
                        debugPrint(error.errorDescription ?? "Unable to get response")
                        Loader.showAlert(message: "unable to get response!")

                        completion(nil)
                    }
                })
        } else {
            completion(nil)
            Loader.showAlert(message: "No Internet!")

        }
    }
}
