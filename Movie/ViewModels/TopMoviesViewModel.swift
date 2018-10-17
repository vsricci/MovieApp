//
//  TopMoviesViewModel.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import Foundation


protocol TopMoviesProtocol {
    var topMoviesDidChange : ((TopMoviesProtocol) -> Void)? { get set }
    var result : Result? { get }
}

class TopMoviesViewModel: TopMoviesProtocol {
    var topMoviesDidChange: ((TopMoviesProtocol) -> Void)?
    
    var result: Result? {
        didSet {
            self.topMoviesDidChange?(self)
        }
    }
    
     func getTopMovies(completion: @escaping (String) -> Void) {
        let url : String = URLS.popularMoviesURL.rawValue + API_KEY
        TopMoviesManager.getTopManager(url: url, params: nil) { (result) in
            
            if let resultResponse = result {
                self.result = resultResponse
            }
        }
    }
}
