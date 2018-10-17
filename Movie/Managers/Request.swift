//
//  Request.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import Alamofire

class Request : NSObject {
    
    static func getFrom(_ url: String, _ parameters: [String: Any]? = nil, headers: [String:String]? = nil ,  completion: @escaping(_ result: Any?, _ error: Any?) -> Void) {
        
        Alamofire.request(url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? url, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                print("GET: \(response.request?.url?.absoluteString ?? "")")
                print("STATUSCODE: \(String(describing: response.response?.statusCode))")
                switch response.result {
                case .success:
                    
                    completion(response.data, nil)
                    break
                    
                case .failure(let error):
                    if let errorResponse = response.data {
                        completion(nil, errorResponse)
                    } else {
                        completion(nil, error)
                    }
                    break
                }
        }
    }
}
