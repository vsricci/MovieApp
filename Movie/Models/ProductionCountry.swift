//
//  ProductionCountry.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionCountry : Object, Codable {
    
    @objc dynamic var iso: String?
    @objc dynamic var name: String?
  
    
//    override class func primaryKey() -> String? {
//        return "name"
//    }
    
    
//    convenience init(iso_3166_1: String, name: String) {
//        self.init()
//        self.iso_3166_1 = iso_3166_1
//        self.name = name
//    }
    
    
    enum CodingKeys : String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
    
//    convenience required init(from decoder: Decoder) throws {
//
//        let container = try! decoder.container(keyedBy: CodingKeys.self)
//        let iso_3166_1 = try container.decode(String.self, forKey: .iso_3166_1)
//        let name = try container.decode(String.self, forKey: .name)
//        self.init(iso_3166_1: iso_3166_1, name: name)
//    }
}
