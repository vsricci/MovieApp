//
//  ProductCompany.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ProductCompany : Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var logo_path: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var origin_country: String = ""
    
    convenience init(id: Int, logo_path: String, name : String, origin_country: String) {
        self.init()
        self.id = id
        self.logo_path = logo_path
        self.name = name
        self.origin_country = origin_country
    }
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case logoPath
        case name
        case originCountry
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let logo_path = try container.decode(String.self, forKey: .logoPath)
        let name = try container.decode(String.self, forKey: .name)
        let origin_country = try container.decode(String.self, forKey: .originCountry)
        self.init(id: id, logo_path: logo_path, name: name, origin_country: origin_country)
        
    }
    
    
}
