//
//  Results.swift
//  Movie
//
//  Created by Vinicius Ricci on 21/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift


class Result: Object, Decodable {
    
    @objc dynamic var page: Int = 0
    @objc dynamic var totalResults: Int = 0
    @objc dynamic var totalPages: Int = 0
    var results = List<Movie>()
    
    
//    override class func primaryKey() -> String? {
//        return "page"
//    }
    
    enum CodingKeys : String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? 0
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        let resultsArray = try container.decode([Movie].self, forKey: .results)
        
        results.append(objectsIn: resultsArray)
    }
    
}
