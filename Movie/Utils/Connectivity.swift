//
//  Connecty.swift
//  Movie
//
//  Created by Vinicius Ricci on 22/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
