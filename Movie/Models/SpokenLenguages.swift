//
//  SpokenLenguages.swift
//  Movie
//
//  Created by Vinicius Ricci on 18/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class SpokenLanguages: Object, Codable {
    
    @objc dynamic var iso: String?
    @objc dynamic var name : String?
    
    enum CodingKeys: String, CodingKey  {
        case iso = "iso_639_1"
        case name
    }
}
