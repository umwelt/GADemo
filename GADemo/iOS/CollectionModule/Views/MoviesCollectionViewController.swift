//
//  MoviesCollectionViewController.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit
import Siesta


class MoviesCollectionViewController: UIViewController, ResourceObserver {
    
    private var dataSource: [Movie] = []
    var statusOverlay = ResourceStatusOverlay(frame: .zero)
    var navigator: GANavigator!
    
    /// data management
    var isLoading = false
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Now Playing"
  
        navigator = GANavigator(navigationController: self.navigationController!)
        
        managedView.collectionView.delegate = self
        managedView.collectionView.dataSource = self
        managedView.searchBar.delegate = self
        
        API.getMoviesNowPlaying(pageNumber: "1")
            .addObserver(self)
            .addObserver(statusOverlay)
        

        searchable()
        // Do any additional setup after loading the view.
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.getMoviesNowPlaying(pageNumber: "1").loadIfNeeded()
    }
    
    private var managedView: MoviesCollectionView {
        get {
            return self.view as! MoviesCollectionView
        }
    }
    
    override func loadView() {
        super.loadView()
        view = MoviesCollectionView()
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        
        guard let jsonData = resource.latestData?.content as? Data else {
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode(Movies.self, from: jsonData)
            if let results = movies.results {
                self.dataSource.append(contentsOf: results)
                self.managedView.collectionView.reloadData()
            }
            
            
        } catch let error {
            print(error)
        }
        
    }

}

extension MoviesCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.dataSource.count - 6 && !isLoading {
            isLoading = true
            self.pageNumber += 1
            self.fetchMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell {
            cell.layer.shouldRasterize = true
            cell.layer.rasterizationScale = UIScreen.main.scale
            cell.with(self.dataSource[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.managedView.endEditing(true)
        if !self.dataSource.isEmpty {
            self.navigator.navigate(to: .movieDetail(movie: self.dataSource[indexPath.row]))
        }
        
    }
    
    func fetchMoreData() {
        
        let repository = Repository()
        repository.getMoviesNowPlaying(pageNumber: String(pageNumber)) { (movies, error) in
            
            if let _error = error {
                /// notifiy error
                print(_error as Any)
            }
            
            if let _movies = movies {
                if let _results = _movies.results {
                    self.dataSource.append(contentsOf: _results)
                    self.managedView.collectionView.reloadData()
                    self.isLoading = false
                }
            }
            
        }
        
        
    }
    
    /// Search
    
    func searchMovie(with query: String) {
        
        self.dataSource.removeAll()
        
        API.searchMovies(with: query).load().onSuccess { (response) in
            let repository = Repository()
            repository.searchMovie(with: query, completion: { (movies, error) in
                
                
                if let _error = error {
                    /// notifiy error
                    print(_error as Any)
                }
                
                if let _movies = movies {
                    
                    if let _results = _movies.results {
                        self.dataSource.append(contentsOf: _results)
                        self.managedView.collectionView.reloadData()
                        self.isLoading = false
                    }
                }
                
                
            })
        }
        
    }
    
}

extension MoviesCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.managedView.endEditing(true)
        self.managedView.searchBar.text?.removeAll()
        self.pageNumber = 1
        
        self.configuredAlert()
    }
    
    func searchable() {
        // Receive events for search
        managedView.searchBar.onSearch = { text in
            if text.count == 0 { // user tapped the 'X' button
                // restore our plain list without search filter
                API.getMoviesNowPlaying(pageNumber: "1").load()
            } else if text.count > 2 {
                self.searchMovie(with: text)
            }
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            /// restore state
        }
        
        guard let throttler = self.managedView.searchBar.throttler else {
            self.managedView.searchBar.onSearch?(searchText)
            return
        }
        throttler.throttle {
            DispatchQueue.main.async {
                self.managedView.searchBar.onSearch?(searchText)
            }
        }
    }
    
    func configuredAlert() {
        
        let alert = AlertPresenter.init(title: "Restart Search", message: nil, okAction: "ok", cancelAction: "Cancel") { (completed) in
            switch completed {
                
            case .accepted:
                self.dismiss(animated: true, completion: nil)
                self.dataSource.removeAll()
                self.fetchMoreData()
            case .rejected:
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        alert.present(self)
    }
    
}
