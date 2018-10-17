//
//  TopMoviesViewController.swift
//  Movie
//
//  Created by Vinicius Ricci on 16/10/18.
//  Copyright © 2018 Vinicius Ricci. All rights reserved.
//

import UIKit

class TopMoviesViewController: UIViewController {
    
    @IBOutlet weak var topMoviesCollectionView: UICollectionView!
    

    var topMoviesViewModel : TopMoviesViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTopMoviesCollectionView()
        topMoviesViewModel = TopMoviesViewModel()
        topMoviesViewModel?.getTopMovies(completion: { (result) in
            print(result)
        })
    }
    
    func configTopMoviesCollectionView() {
        topMoviesCollectionView.delegate = self
        topMoviesCollectionView.dataSource = self
    }

   

}

extension TopMoviesViewController : UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMovieCell", for: indexPath) as? UICollectionViewCell {
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}

extension TopMoviesViewController : UICollectionViewDataSource {
    
}
