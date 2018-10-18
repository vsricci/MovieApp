//
//  ProductionCountry.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionCountry : Object, Decodable {
    
    @objc dynamic var iso_3166_1: String = ""
    @objc dynamic var name: String = ""
    
    convenience init(iso: String, name: String) {
        self.iso_3166_1 = iso
        self.name = name
    }
    
    
    enum CodingKeys : String, CodingKey {
        case iso_3166_1
        case name
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let iso = try! container.decode(String.self, forKey: .iso_3166_1)
        let name = try! container.decode(String.self, forKey: .name)
        self.init(iso: iso, name: name)
    }
}
