//
//  TopMoviesViewModel.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift

protocol TopMoviesProtocol {
    var topMoviesDidChange : ((TopMoviesProtocol) -> Void)? { get set }
    var results : Result? { get }
}

class TopMoviesViewModel: TopMoviesProtocol {
    var topMoviesDidChange: ((TopMoviesProtocol) -> Void)?
    
    var results: Result? {
        didSet {
            self.topMoviesDidChange?(self)
        }
    }
    var currentPage = 1
    var language = ""
    
    required init()
    {
        results = Result()
        
    }
    
    var list = List<Movie>()
    
     func getTopMovies(completion: @escaping (String) -> Void) {
        let url : String = URLS.popularMoviesURL.rawValue + API_KEY + "&language=\(language)&page=\(currentPage)"
        TopMoviesManager.getTopManager(url: url, params: nil) { (result) in
            
            if let resultResponse = result {
                self.results = resultResponse
                if resultResponse.page == 1
                {
                    self.results = resultResponse
                    for movies in (self.results?.results)! {
                        self.list.append(movies)
                    }
                }
                else
                {
                    let oldList = self.results
                    oldList?.results = resultResponse.results
                    oldList?.page = resultResponse.page

                    self.results = oldList
                    for movies in (self.results?.results)! {
                        self.list.append(movies)
                    }
                }
                
                self.results?.results = self.list
            }
            else {
                completion("Erro!!!")
            }
        }
    }
    
    
    func getFavoritePopularMovies() -> Results<DetailMovie> {
        
        let realm = try! Realm()
        
        realm.beginWrite()
        let listResults = realm.objects(DetailMovie.self)
        try! realm.commitWrite()
        
        return listResults
    }
    
    func topMovieNumbers() -> Int {
        return self.results?.results.count ?? 0
    }
    
}
