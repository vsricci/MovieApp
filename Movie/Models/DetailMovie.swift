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
    
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdrop_path: String = ""
    @objc dynamic var budget : Int = 0
    var genres = List<Genre>()
    @objc dynamic var homepage : String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imbd_id : String = ""
    @objc dynamic var original_language : String = ""
    @objc dynamic var original_title : String = ""
    @objc dynamic var overview : String = ""
    @objc dynamic var popularity : Double = 0
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
    
    convenience init(adult: Bool, backdrop_path: String, budget: Int, homepage: String, id: Int, imbd_id: String, original_language: String, original_title: String, overview: String, popularity: Double, poster_path: String, release_date: String, runtime: Int, status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, genres: List<Genre>, production_companies: List<ProductCompany>, production_countries: List<ProductionCountry>, spoken_languages: List<SpokenLanguages> ) {
        self.init()
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.budget = budget
        self.homepage = homepage
        self.id = id
        self.imbd_id = imbd_id
        self.original_title = original_title
        self.original_language = original_language
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.production_companies = production_companies
        self.production_country = production_countries
        self.spoken_languages = spoken_languages
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
        let adult = try container.decode(Bool.self, forKey: .adult)
        let backdropPath = try container.decode(String.self, forKey: .backdrop_path)
        let budget = try container.decode(Int.self, forKey: .budget)
        let genres = try container.decode([Genre].self, forKey: .genres)
        let homepage = try container.decode(String.self, forKey: .homepage)
        let id = try container.decode(Int.self, forKey: .id)
        let imdb_id = try container.decode(String.self, forKey: .imdb_id)
        let originalLanguage = try container.decode(String.self, forKey: .original_language)
        let originalTitle = try container.decode(String.self, forKey: .original_title)
        let overview = try container.decode(String.self, forKey: .overview)
        let popularity = try container.decode(Double.self, forKey: .popularity)
        let posterPath = try container.decode(String.self, forKey: .poster_path)
        let productionCompanies = try container.decode([ProductCompany].self, forKey: .production_companies)
        let productionCountries = try container.decode([ProductionCountry].self, forKey: .production_countries)
        let releaseDate = try container.decode(String.self, forKey: .release_date)
       // let revenue = try container.decode(Int.self, forKey: .revenue)
        let runtime = try container.decode(Int.self, forKey: .runtime)
        let spokenLanguages = try container.decode([SpokenLanguages].self, forKey: .spoken_languages)
        let status = try container.decode(String.self, forKey: .status)
        let tagline = try container.decode(String.self, forKey: .tagline)
        let title = try container.decode(String.self, forKey: .title)
        let video = try container.decode(Bool.self, forKey: .video)
        let voteCount = try container.decode(Int.self, forKey: .voteCount)
        let vote_average = try container.decode(Double.self, forKey: .voteAverate)
        
        
        let genre = List<Genre>()
        genre.append(objectsIn: genres)
        
        let productCompany = List<ProductCompany>()
        productCompany.append(objectsIn: productionCompanies)
        
        let productCountry = List<ProductionCountry>()
        productCountry.append(objectsIn: productionCountries)
        
        let spokenLanguage = List<SpokenLanguages>()
        spokenLanguage.append(objectsIn: spokenLanguages)
        
        self.init(adult: adult, backdrop_path: backdropPath, budget: budget, homepage: homepage, id: id, imbd_id: imdb_id, original_language: originalLanguage, original_title: originalTitle, overview: overview, popularity: popularity, poster_path: posterPath, release_date: releaseDate, runtime: runtime, status: status, tagline: tagline, title: title, video: video, voteAverage: vote_average, voteCount: voteCount, genres: genre, production_companies: productCompany, production_countries: productCountry, spoken_languages: spokenLanguage)
        
    }
}
