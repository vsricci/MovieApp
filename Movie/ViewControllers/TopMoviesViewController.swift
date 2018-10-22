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
    

   
    // var currentPage = 20
     var isLoading:Bool = false
     var refreshControl: UIRefreshControl!
     var footerView: RefreshCollectionViewCell?
     var favoriteTopMovie: Results<DetailMovie>!
     var favoriteMovie : [DetailMovie] = []
     let searchController = UISearchController(searchResultsController: nil)
     var filterTopMovies: [Movie] = []
     var topMovies: [Movie] = []
    
    var topMoviesViewModel : TopMoviesViewModel? {
        didSet {
            topMoviesViewModel?.topMoviesDidChange = { _ in
                Spinner.shared.stopAnimating()
                
                self.getTopMovies(popularMovies: (self.topMoviesViewModel?.results?.results) ?? List<Movie>())
                self.getFavoriteMovies()
                self.topMoviesCollectionView.reloadData()
                self.stopRefresher()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.topMoviesCollectionView.reloadData()
    }
    
    func getTopMovies(popularMovies : List<Movie>) {
        
        
        self.topMovies.append(contentsOf: popularMovies)
        self.filterTopMovies = self.topMovies
    
        DispatchQueue.main.async {
            self.topMoviesCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.title = "Popular Movies"
         self.configTopMoviesCollectionView()
        
        topMoviesViewModel = TopMoviesViewModel()
        getTopMovies(currentPage: 1)
        configPullToRefresh(object: topMoviesCollectionView)
        configSerchBar()
       
    }
    
    func configSerchBar() {
        
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup the Scope Bar
       // searchController.searchBar.scopeButtonTitles = ["All", "Favorite"]
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
    }
    
    
    func getTopMovies(currentPage: Int) {
        
        if Connectivity.isConnectedToInternet == true {
            Spinner.shared.show(view: self.view)
            topMoviesViewModel?.getTopMovies(completion: { (error) in
                Spinner.shared.stopAnimating()
                print(error)
            })
        }
        else {
            self.setNavigationType(.present, viewController: Alert.showNotConnect(controller: self))
        }
       
    }
    
    func getFavoriteMovies() {
        favoriteTopMovie = self.topMoviesViewModel?.getFavoritePopularMovies()
        self.favoriteMovie.append(contentsOf: favoriteTopMovie)
        for item in favoriteTopMovie {
            print("favorited: \(item.id)")
        }
        
    }
    
    
    func configPullToRefresh(object: AnyObject)
    {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        object.addSubview(refreshControl)
    }
    
   
    
    @objc func refresh()
    {
        print("-->> Pull to Refresh <<--")
        self.topMoviesViewModel?.list.removeAll()
        self.topMoviesViewModel?.currentPage = 1
        getTopMovies(currentPage: 1)
    }
    
    func stopRefresher() {
        refreshControl.endRefreshing()
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
    
    //MARK: - Navigation
    
    func navtoDetailTopMovie(movieID: Int?) {
        let detailTopMovieVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailTopMovieIdentifier") as! DetailsTopMoviesViewController
        detailTopMovieVC.movieID = movieID
        self.navigationController?.pushViewController(detailTopMovieVC, animated: true)
        
    }

}

extension TopMoviesViewController : UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return self.filterTopMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topMovieCell", for: indexPath) as? TopMovieCollectionViewCell {
           
                let topMovie = self.filterTopMovies[indexPath.row]
                cell.topMovieImage.download(image: imageBegginURL + (topMovie.poster_path)!, placeholder: "")
                cell.topNameMovieLabel.text = topMovie.title
                
                for favoriteMovieItem in self.favoriteTopMovie {
                    if favoriteMovieItem.id == topMovie.id {
                        print(favoriteMovieItem.id )
                        DispatchQueue.main.async {
                            cell.favoriteTopMovieImageView.isHidden = false
                            cell.favoriteTopMovieImageView.image = UIImage(named: "favorite_full_icon")
                        }
                    }else {
                        cell.favoriteTopMovieImageView.isHidden = true
                    }
                }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isLoading {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "refreshCollectionViewCell", for: indexPath) as! RefreshCollectionViewCell
            self.footerView = aFooterView
            self.footerView?.backgroundColor = UIColor.clear
            return aFooterView
        } else {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "refreshCollectionViewCell", for: indexPath)
            return headerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.prepareInitialAnimation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.stopAnimate()
        }
    }
    
    // MARK: - Private instance methods
    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//
//       // if scope == "All" {
//            filterTopMovies = (self.topMoviesViewModel?.results?.results.filter({( movie : Movie) -> Bool in
//                let doesCategoryMatch = (scope == "All") || (movie.original_title == scope)
//
//
//                if searchBarIsEmpty() {
//                    return doesCategoryMatch
//                } else  {
//                    return doesCategoryMatch && movie.original_title?.lowercased().contains(searchText.lowercased()) ?? Bool()
//                }
//            }))!
    //    }
//        else {
//            favoriteMovie = (self.favoriteTopMovie?.filter({( movie : DetailMovie) -> Bool in
//                let doesCategoryMatch = (scope == "Favorite") || (movie.original_title == scope)
//
//
//                if searchBarIsEmpty() {
//                    return doesCategoryMatch
//                } else  {
//                    return doesCategoryMatch && movie.original_title?.lowercased().contains(searchText.lowercased()) ?? Bool()
//                }
//            }))!
//        }
       
//        topMoviesCollectionView.reloadData()
//    }
    
//    func searchBarIsEmpty() -> Bool {
//        return searchController.searchBar.text?.isEmpty ?? true
//    }
//
//    func isFiltering() -> Bool {
//        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
//        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
//    }
}


extension TopMoviesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let topMovie = self.filterTopMovies[indexPath.row]
       
        navtoDetailTopMovie(movieID: topMovie.id)
    }
}

extension TopMoviesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        return CGSize(width: width*0.49, height: height*0.5)
    }
}


extension TopMoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold   = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold  = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold   =  min(triggerThreshold, 0.0)
        let pullRatio  = min(fabs(triggerThreshold),1.0);
        self.footerView?.setTransform(inTransform: CGAffineTransform.identity, scaleFactor: CGFloat(pullRatio))
        if pullRatio >= 1 {
            self.footerView?.animateFinal()
        }
       // print("pullRation:\(pullRatio)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight  = fabs(diffHeight - frameHeight);
      //  print("pullHeight:\(pullHeight)");
        if pullHeight >= 0.0
        {
            if (self.footerView?.isAnimatingFinal)! {
                print("load more trigger")
                self.isLoading = true
                self.footerView?.startAnimate()
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer:Timer) in
                    self.topMoviesViewModel?.currentPage += 1
                    let page = (self.topMoviesViewModel?.currentPage ?? 1) + 1
                    self.getTopMovies(currentPage: page)
                    self.isLoading = false
                })
            }
        }
    }
}
extension TopMoviesViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text == "" {
            self.filterTopMovies = self.topMovies
        }else {
            filterTopMovies = (self.topMoviesViewModel?.results?.results.filter({( movie : Movie) -> Bool in
                return movie.original_title?.lowercased().contains(searchText.lowercased()) ?? Bool()
            }))!
        }

        self.topMoviesCollectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("tsete")
        self.topMoviesCollectionView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
}

//extension TopMoviesViewController: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
//    }
//}
