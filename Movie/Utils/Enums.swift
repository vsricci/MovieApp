//
//  Enums.swift
//  Movie
//
//  Created by Vinicius Ricci on 21/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

enum URLS : String {
    case popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key="
    case detailMovieURL = "https://api.themoviedb.org/3/movie/"
    
}

enum NavigationType : String {
    case present
    case navigationController
    case presentFade
}

enum StoryboardIdentifier : String {
    case DetailTopMovieIdentifier = "DetailTopMovieIdentifier"
}

enum Storyboards : String {
    case Main
}

enum Images : String{
    case favorite =  "favorite_full_icon"
}

enum IdentifierCell : String {
    case topMovie = "topMovieCell"
    case refresh = "refreshCollectionViewCell"
}
