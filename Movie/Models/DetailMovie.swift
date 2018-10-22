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
    @objc dynamic var backdrop_path: String?
    @objc dynamic var budget: Int = 0
    var genres = List<Genre>()
    @objc dynamic var homepage: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var imdb_id : String?
    @objc dynamic var original_language : String?
    @objc dynamic var original_title : String?
    @objc dynamic var overview : String?
    @objc dynamic var popularity : Double = 0.0
    @objc dynamic var poster_path : String?
    var productionCompanies = List<ProductionCompany>()
    var productionCountries = List<ProductionCountry>()
    @objc dynamic var release_date : String?
    @objc dynamic var runtime: Int = 0
    @objc dynamic var revenue : Int = 0
    var spokenLanguages = List<SpokenLanguages>()
    @objc dynamic var status : String?
    @objc dynamic var tagline : String? = ""
    @objc dynamic var title : String?
    @objc dynamic var video : Bool = false
    @objc dynamic var vote_average : Double = 0.0
    @objc dynamic var vote_count : Int = 0
    
    
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
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case release_date
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case vote_average
        case vote_count
    }
    
    
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
         self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? Bool()
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
         self.budget = try container.decodeIfPresent(Int.self, forKey: .budget) ?? 0
         let genreArray = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? [Genre()]
         self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
         self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
         self.imdb_id = try container.decodeIfPresent(String.self, forKey: .imdb_id)
         self.original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
         self.original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
         self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
         self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
         self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        let productionCompaniesArray = try container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies) ?? [ProductionCompany()]
        let productionCountriesArray = try container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries) ?? [ProductionCountry()]
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.revenue = try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0
        let spokenLanguagesArray = try container.decodeIfPresent([SpokenLanguages].self, forKey: .spokenLanguages) ?? [SpokenLanguages()]
       self.status = try container.decodeIfPresent(String.self, forKey: .status)
       self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
       self.title = try container.decodeIfPresent(String.self, forKey: .title)
       self.video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? Bool()
       self.vote_count = try container.decodeIfPresent(Int.self, forKey: .vote_count) ?? 0
       self.vote_average = try container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0


        genres.append(objectsIn: genreArray)
        productionCompanies.append(objectsIn: productionCompaniesArray)
        productionCountries.append(objectsIn: productionCountriesArray)
        spokenLanguages.append(objectsIn: spokenLanguagesArray)

        
    }
    
   
}
