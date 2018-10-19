//
//  SpokenLenguages.swift
//  Movie
//
//  Created by Vinicius Ricci on 18/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class SpokenLanguages: Object, Decodable {
    
    @objc dynamic var iso_639_1: String = ""
    @objc dynamic var name : String = ""
    
    convenience init(iso: String, name: String) {
        self.init()
        self.iso_639_1 = iso
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey  {
        case iso
        case name
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let iso = try! container.decode(String.self, forKey: .iso)
        let name = try! container.decode(String.self, forKey: .name)
        self.init(iso: iso, name: name)
    }
}
