//
//  DetailMovie.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class DetailMovie: Object, Decodable {
    
    @objc dynamic var adult: String = ""
    @objc dynamic var backdrop_path: String = ""
    @objc dynamic var budget : Int = 0
    var genres = ListGenre()
    @objc dynamic var homepage : String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var imbd_id : String = ""
    @objc dynamic var original_language : String = ""
    @objc dynamic var original_title : String = ""
    @objc dynamic var overview : String = ""
    @objc dynamic var popularity : Int = 0
    @objc dynamic var poster_path : String = ""
    var production_companies = List<ProductCompany>()
    var production_country = List<ProductionCountry>()
    @objc dynamic var release_date : String = ""
    @objc dynamic var runtime : Int = 0
    var spoken_languages = List<SpokenLanguages>()
    @objc dynamic var status : String = ""
    @objc dynamic var tagline : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var video : Bool = false
    @objc dynamic var vote_average : Double = 0
    @objc dynamic var vote_count : Int = 0
    
    convenience init(adult: String, backdrop_path: String, budget: Int, genres: ListGenre, homepage: String, id: String, imbd_id: String, original_language: String, original_title: String, overview: String, popularity: Int, poster_path: String, productionCompanies: List<ProductCompany>, productionCountries: List<ProductionCountry>, release_date: String, runtime: Int, spokenLanguages: List<SpokenLanguages>, status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int) {
        self.init()
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imbd_id = imbd_id
        self.original_title = original_title
        self.original_language = original_language
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.production_companies = productionCompanies
        self.production_country = productionCountries
        self.original_title = original_title
        self.genres = genres
        self.backdrop_path = backdrop_path
        self.overview = overview
        self.release_date = release_date
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.vote_average = voteAverage
        self.vote_count = voteCount
        
    }
    
    enum CodingKeys : String, CodingKey {
        
        case adult
        case backdrop_path
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case production_companies
        case production_countries
        case release_date
        case revenue
        case runtime
        case spoken_languages
        case status
        case tagline
        case title
        case video
        case voteAverate
        case voteCount
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let vote_average = try container.decode(Double.self, forKey: .vote_average)
        let poster_path = try container.decode(String.self, forKey: .poster_path)
        let original_title = try container.decode(String.self, forKey: .original_title)
        let gentesArray = try container.decode([Int].self, forKey: .genre_ids)
        let backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        let overview = try container.decode(String.self, forKey: .overview)
        let release_date = try container.decode(String.self, forKey: .release_date)
        
        
        let genre_ids = List<Int>()
        genre_ids.append(objectsIn: gentesArray)
        self.init(title: title, vote_average: vote_average, poster_path: poster_path, original_title: original_title, genres: genre_ids, backdrop_path: backdrop_path, overview: overview, release_date: release_date)
        
    }
}
