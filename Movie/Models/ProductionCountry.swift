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
    
    enum CodingKeys : String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
}
