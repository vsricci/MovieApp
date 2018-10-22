//
//  DetailsTopMovieViewModel.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation
import RealmSwift


protocol DetailsTopMoviesProtocol {
    var detailTopMovieDidChange : ((DetailsTopMoviesProtocol) -> Void)? { get set }
    var detailsTopMovie : DetailMovie? { get }
    
}
class DetailsTopMovieViewModel : DetailsTopMoviesProtocol {
    
    var detailTopMovieDidChange: ((DetailsTopMoviesProtocol) -> Void)?

    var detailsTopMovie: DetailMovie?{
        didSet {
            self.detailTopMovieDidChange?(self)
        }
    }
    
    var movieID: Int = 0
    
    func getFavoritePopularMovie(movie: DetailMovie) {
        let realm = try! Realm()
        
        do {
            try!
                realm.write {
                    realm.add(movie)
                    
            }
        }
        
    }
    
    func getDetailsTopMovies(completion: @escaping (String) -> Void) {
        let movieID = self.movieID
        let url = URLS.detailMovieURL.rawValue + "\(movieID)?api_key=" + API_KEY
        TopMoviesManager.getDetailsTopMovies(url: url, params: nil) { (result) in
            
            if let resultResponse = result {
                self.detailsTopMovie = resultResponse
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
}
