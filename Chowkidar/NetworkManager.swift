//
//  NetworkManager.swift
//

import UIKit
import Foundation
import Alamofire

class NetworkManager: NSObject {
    
    /// Alamofilre:  Get request
    /// - Parameters:
    ///   - urlService: URL in String format for api call
    ///   - param: Parameters for api call
    ///   - head: Header for api call
    ///   - queryItems: Querry items for api call
    ///   - responseType: Response model tyle
    ///   - completion: A block to execute fpr api call response success ot failure
    
    class func get_Request<T: Codable>(urlService: String, param: [String : Any]?, head: HTTPHeaders?, queryItems: [URLQueryItem]? = nil, responseType: T.Type, completion: @escaping (_ anyObject: Any?,_ statusCode: Int?) -> Void) {
        if Connectivity.isConnectedToInternet {
            var tempURL: URL?
            guard let urlString = URL(string: kBASE_URL + urlService) else {
                completion(nil, nil)
                return
            }
            if let query = queryItems {
                guard var baseURLComponent = URLComponents.init(url: urlString, resolvingAgainstBaseURL: false) else {
                    completion(nil, nil)
                    return
                }
                baseURLComponent.queryItems = query
                tempURL = baseURLComponent.url
            } else {
                tempURL = urlString
            }
            
            guard let apiURL = tempURL else {
                completion(nil, nil)
                return
            }
            
            let parameter = param
            let header = head
            
            AF.request(apiURL, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header)
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
                        completion(apiResponse, response.response?.statusCode)
                    case .failure(let error):
                        debugPrint(error.errorDescription ?? "Unable to get response")
                        Loader.showAlert(message: "Unable to get response")
                        completion(nil, nil)
                    }
                })
        } else {
            completion(nil, nil)
            Loader.showAlert(message: "No Internet connection!!!")
        }
    }
    
    /// Alamofilre:  Post request
    /// - Parameters:
    ///   - urlService: URL in String format for api call
    ///   - param: Parameters for api call
    ///   - head: Header for api call
    ///   - queryItems: Querry items for api call
    ///   - responseType: Response model tyle
    ///   - completion: A block to execute fpr api call response success ot failure
    
    class func post_Request<T: Codable>(urlService: String, param: [String : Any]?, head: HTTPHeaders?, queryItems: [URLQueryItem]? = nil, responseType: T.Type, completion: @escaping (_ anyObject: Any?,_ statusCode: Int?) -> Void) {
        if Connectivity.isConnectedToInternet {
            var tempURL: URL?
            guard let urlString = URL(string: kBASE_URL + urlService) else {
                completion(nil, nil)
                return
            }
            if let query = queryItems {
                guard var baseURLComponent = URLComponents.init(url: urlString, resolvingAgainstBaseURL: false) else {
                    completion(nil, nil)
                    return
                }
                baseURLComponent.queryItems = query
                tempURL = baseURLComponent.url
            } else {
                tempURL = urlString
            }
            
            guard let apiURL = tempURL else {
                completion(nil, nil)
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
                        print("response.data")
                        completion(apiResponse, response.response?.statusCode)
                    case .failure(let error):
                        debugPrint(error.errorDescription ?? "Unable to get response")
                        Loader.showAlert(message: "Unable to get response")
                        completion(nil, nil)
                    }
                })
        } else {
            completion(nil, nil)
            
            Loader.showAlert(message: "No Internet connection!!!")
        }
    }
    /*
    /// Alamofilre:  Put request
    /// - Parameters:
    ///   - urlService: URL in String format for api call
    ///   - param: Parameters for api call
    ///   - head: Header for api call
    ///   - queryItems: Querry items for api call
    ///   - responseType: Response model tyle
    ///   - completion: A block to execute fpr api call response success ot failure
    
    class func put_Request<T: Codable>(urlService: String, param: [String : Any]?, head: HTTPHeaders?, queryItems: [URLQueryItem]? = nil, responseType: T.Type, completion: @escaping (_ anyObject: Any?) -> Void) {
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
            
            AF.request(apiURL, method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: header)
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
                        Loader.showAlert(message: "Unable to get response")
                        completion(nil)
                    }
                })
        } else {
            completion(nil)
            Loader.showAlert(message: "No Internet connection!!!")
        }
    }
    
    /// Alamofilre:  Delete request
    /// - Parameters:
    ///   - urlService: URL in String format for api call
    ///   - param: Parameters for api call
    ///   - head: Header for api call
    ///   - queryItems: Querry items for api call
    ///   - responseType: Response model tyle
    ///   - completion: A block to execute fpr api call response success ot failure
    
    class func delete_Request<T: Codable>(urlService: String, param: [String : Any]?, head: HTTPHeaders?, queryItems: [URLQueryItem]? = nil, responseType: T.Type, completion: @escaping (_ anyObject: Any?) -> Void) {
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
            
            AF.request(apiURL, method: .delete, parameters: parameter, encoding: JSONEncoding.default, headers: header)
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
                        Loader.showAlert(message: "Unable to get response")
                        completion(nil)
                    }
                })
        } else {
            completion(nil)
            Loader.showAlert(message: "No Internet connection!!!")
        }
    }
    */
}
