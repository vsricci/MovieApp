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
    @objc dynamic var name : String = ""
    
    
    
    
    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
        
        
        
    }
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case name
        
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let id = try! container.decode(Int.self, forKey: .id)
        let name = try! container.decode(String.self, forKey: .name)
        self.init(id: id, name: name)
    }
}
