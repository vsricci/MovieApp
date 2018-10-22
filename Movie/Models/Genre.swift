//
//  Genre.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class Genre : Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name : String?
    

    enum CodingKeys : String, CodingKey {
        
        case id
        case name
    }
    
}
