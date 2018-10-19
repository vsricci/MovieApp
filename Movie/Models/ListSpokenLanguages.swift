//
//  ListSpokenLanguages.swift
//  Movie
//
//  Created by Vinicius Ricci on 18/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ListSpokenLanguages : Object, Decodable {
    
    var spoken_languages = List<SpokenLanguages>()
    
    convenience init(spoken_languages:  List<SpokenLanguages>) {
        self.init()
        self.spoken_languages = spoken_languages
    }
    
    
    enum CodingKeys : String, CodingKey {
        case spokenLanguages
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let spoken_languages = try! container.decode([SpokenLanguages].self, forKey: .spokenLanguages)
        let spokenLanguages = List<SpokenLanguages>()
        spokenLanguages.append(objectsIn: spoken_languages)
        self.init(spoken_languages: spokenLanguages)
    }
}
