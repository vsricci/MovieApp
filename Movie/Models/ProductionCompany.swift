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
    
    
    enum CodingKeys : String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
        
    }
}
