//
//  Movie.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class Movie : Object, Decodable{
    
    @objc dynamic var id : Int = 0
    @objc dynamic var title: String?
    @objc dynamic var vote_average: Double = 0.0
    @objc dynamic var poster_path : String?
    @objc dynamic var original_title: String?
    var genres = List<Int>()
    @objc dynamic var backdrop_path : String?
    @objc dynamic var overview: String?
    @objc dynamic var release_date : String?
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
    
    
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case title
        case vote_average
        case poster_path
        case original_title
        case genre_ids
        case backdrop_path
        case overview
        case release_date
        case descriptionGenre
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.vote_average = try container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
        let gentesArray = try container.decodeIfPresent([Int].self, forKey: .genre_ids) ?? [Int()]
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        
        genres.append(objectsIn: gentesArray)
    }
}
