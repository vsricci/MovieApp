//
//  Genres.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation

class ListGenre: Object, Decodable {
    
    var genres = List<Genre>()
    
    convenience init(genres: List<Genre>) {
        self.init()
        self.genres = genres
    }
    
    enum CodingKeys : String, CodingKey {
        
        case genres
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let genresArray = try! container.decode([Genre].self, forKey: .genres)
        let genre = List<Genre>()
        genre.append(objectsIn: genresArray)
        self.init(genres: genre)
        
    }
    
}
