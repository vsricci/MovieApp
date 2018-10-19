//
//  ListProductionCountry.swift
//  Movie
//
//  Created by Vinicius Ricci on 18/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ListProductionCountry : Object, Decodable {
    
    var production_countries = List<ProductionCountry>()
    
    convenience init(production_companies:  List<ProductionCountry>) {
        self.init()
        self.production_countries = production_companies
    }
    
    
    enum CodingKeys : String, CodingKey {
        case productionCountries
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let production_countries = try! container.decode([ProductionCountry].self, forKey: .productionCountries)
        let produciontCountries = List<ProductionCountry>()
        produciontCountries.append(objectsIn: produciontCountries)
        self.init(production_companies: produciontCountries)
    }
}
