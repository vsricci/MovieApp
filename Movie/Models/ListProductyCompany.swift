//
//  ProductCompany.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

class ListProductyCompany : Object, Decodable {
    
    var production_companies = List<ProductCompany>()
    
    convenience init(production_companies:  List<ProductCompany>) {
        self.production_companies = production_companies
    }
   
    
    enum CodingKeys : String, CodingKey {
        case productionCompanies
    }
    
    convenience required init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        let production_companies = try! container.decode([ProductCompany].self, forKey: .productionCompanies)
        let productCompanies = List<ProductCompany>()
        productCompanies.append(objectsIn: production_companies)
        self.init(production_companies: productCompanies)
    }
}
