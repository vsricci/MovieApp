//
//  TopMoviesManager.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation


class TopMoviesManager  {
    
    static func getTopManager(url: String?, params: [String: Any]?, completion: @escaping (Result?) -> Void) {
        
        Request.getFrom(url ?? "", params, headers: nil) { (result, error) in
            
            if let data = result as? Data {
                if let  result = try? JSONDecoder().decode(Result.self, from: data) {
                    if let jsonString = String(data: data, encoding: .utf8) {
                       // print(jsonString)
                        
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        
                        completion(result)
                    }
                }
            }
            else if let error = error as? Data {
              //  let apiMessage = ApiError(dataJSON: JSON(error))
               // completion(nil,apiMessage)
                
            } else {
               // completion(nil, ErrorManager.error(type: .unknown))
                
            }
            
        }
    }
}
