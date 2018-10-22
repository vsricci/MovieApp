//
//  Alert.swift
//  Movie
//
//  Created by Vinicius Ricci on 21/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class Alert: NSObject {

    static func showMessageAddFavoriteTopMovie(controller: UIViewController) -> UIViewController {
        
        let alert = UIAlertController(title: "Success", message: "Top Movie Favorited!!!", preferredStyle: .alert)
        
        if let detailTopMovieVC = controller as? DetailsTopMoviesViewController {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_ ) in
                detailTopMovieVC.detailTopMovieViewModel?.getFavoritePopularMovie(movie: detailTopMovieVC.detailTopMovieViewModel?.detailsTopMovie ?? DetailMovie())
            }))
        }
    
        return alert
    }
    
    static func showNotConnect(controller: UIViewController) -> UIViewController  {
        let alert = UIAlertController(title: "No Connection", message: "Disconnected!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Again", style: .default) { (_ ) in
        
            if let detailTopMovieVC = controller as? DetailsTopMoviesViewController {
                detailTopMovieVC.getDetailsTopMovies()
                
            }
            else if let topMovieVC = controller as? TopMoviesViewController {
                topMovieVC.getTopMovies(currentPage: topMovieVC.topMoviesViewModel?.currentPage ?? 0)
            }
        }
        alert.addAction(action)
    return alert
    }
    
    static func showIsFavorited() -> UIViewController {
        let alert = UIAlertController(title: "Favorited", message: "Its Favorited!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_ ) in
        }
        alert.addAction(action)
        return alert
    }
}
