//
//  ProductCompany.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class ProductionCompany : Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String?
    @objc dynamic var name: String?
    @objc dynamic var originCountry: String?
    
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
//    convenience init(name: String/*, logo_path: String, name: String, origin_country: String*/) {
//        self.init()
//        self.name = name
////        self.logo_path = logo_path
////        self.name = name
////        self.origin_country = origin_country
//    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
        
    }
    
//    convenience required init(from decoder: Decoder) throws {
//        self.init()
//        let container = try! decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.logo_path = try container.decode(String.self, forKey: .logo_path)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.origin_country = try container.decode(String.self, forKey: .origin_country)
//        
//    }
    
    
}
