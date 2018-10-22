//
//  DetailsTopMoviesViewController.swift
//  Movie
//
//  Created by Vinicius Ricci on 17/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

class DetailsTopMoviesViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var detailTopMovieNameLabel: UILabel!
    @IBOutlet weak var detailOverviewTopMovieLabel: UILabel!
    @IBOutlet weak var detailTopMoieImageView: UIImageView!
    @IBOutlet weak var numberOfChannelsLabel: UILabel!
    @IBOutlet weak var numberOfViwsLabel: UILabel!
    @IBOutlet weak var favoriteTopMovieButton: UIButton!

    
    //MARK: - Variables
    var detailTopMovieViewModel: DetailsTopMovieViewModel? {
        didSet {
            detailTopMovieViewModel?.detailTopMovieDidChange = { _ in
                Spinner.shared.stopAnimating()
                self.configDetailInformation()
            }
        }
    }
    
    var movieID : Int?
    var realm = try! Realm()
    var favoriteTopMovie: Results<DetailMovie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Details Popular Movies"
        
        detailTopMovieViewModel = DetailsTopMovieViewModel()
        detailTopMovieViewModel?.movieID = movieID ?? 0
        getDetailsTopMovies()
        self.favoriteTopMovie = self.detailTopMovieViewModel?.getFavoritePopularMovies()
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
        if isFavorite() == true {
            self.setNavigationType(.present, viewController: Alert.showIsFavorited())
        }else {
            self.favoriteTopMovieButton.isSelected = !self.favoriteTopMovieButton.isSelected
            
            if self.favoriteTopMovieButton.isSelected == true {
                
                self.setNavigationType(.present, viewController: Alert.showMessageAddFavoriteTopMovie(controller: self))
            }
        }
        
        
    }
    
    func isFavorite() -> Bool {
        var success = Bool()
        let detailTopMovie = self.detailTopMovieViewModel?.detailsTopMovie
        for favoriteMovie in self.favoriteTopMovie {
            
            if detailTopMovie?.id == favoriteMovie.id {
                print("fav: \(favoriteMovie.id)")
                success = true
            }
        }
        return success
    }
    
    func getDetailsTopMovies() {
        
        if Connectivity.isConnectedToInternet == true {
            Spinner.shared.show(view: self.view)
            detailTopMovieViewModel?.getDetailsTopMovies { (error) in
                Spinner.shared.stopAnimating()
                print(error)
            }
        }else {
            self.setNavigationType(.present, viewController: Alert.showNotConnect(controller: self))
        }
        
    }

   
    
    func configDetailInformation() {
        
        if let detailTopMovie = self.detailTopMovieViewModel?.detailsTopMovie {
            self.detailTopMoieImageView.download(image: imageBegginURL + (detailTopMovie.backdrop_path ?? ""), placeholder: "")
            if isFavorite() == true {
                self.favoriteTopMovieButton.setImage(UIImage(named: Images.favorite.rawValue), for: .normal)
            }
            self.detailTopMovieNameLabel.text = detailTopMovie.title
            self.detailOverviewTopMovieLabel.text = detailTopMovie.overview
            self.numberOfChannelsLabel.text = "\(detailTopMovie.vote_count)"
            self.numberOfViwsLabel.text = "\(detailTopMovie.vote_average)"
            
        }
    }
}
