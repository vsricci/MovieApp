//
//  TopMoviesViewController.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit
import RealmSwift

class TopMoviesViewController: UIViewController {
    
    @IBOutlet weak var topMoviesCollectionView: UICollectionView!
    

    var topMoviesViewModel : TopMoviesViewModel? {
        didSet {
            topMoviesViewModel?.topMoviesDidChange = { _ in
                self.topMoviesCollectionView.reloadData()
                
               
            }
        }
    }
    
    var popularMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.configTopMoviesCollectionView()
        
        topMoviesViewModel = TopMoviesViewModel()
        topMoviesViewModel?.getTopMovies(completion: { (error) in
            print(error)
        })
       
    }
    
    func configTopMoviesCollectionView() {
        topMoviesCollectionView.delegate = self
        topMoviesCollectionView.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        topMoviesCollectionView!.collectionViewLayout = layout
    }

   

}

extension TopMoviesViewController : UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topMoviesViewModel?.topMovieNumbers() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMovieCell", for: indexPath) as? TopMovieCollectionViewCell {
           
            let topMovie = self.topMoviesViewModel?.result?.results[indexPath.row]
            cell.topMovieImage.download(image: imageBegginURL + (topMovie?.poster_path)!, placeholder: "")
            cell.topNameMovieLabel.text = topMovie?.title
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}

extension TopMoviesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension TopMoviesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        return CGSize(width: width*0.49, height: height*0.4)
    }
}
