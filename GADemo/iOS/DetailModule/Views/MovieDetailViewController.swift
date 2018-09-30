//
//  MovieDetailViewController.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    
    init(movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        self.movie = movie
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.originalTitle ?? "Unavailable"
        managedView.with(movie)
        // Do any additional setup after loading the view.
    }
    
    var managedView: MovieDetailView {
        get {
            return self.view as! MovieDetailView
        }
    }
    
    override func loadView() {
        super.loadView()
        view = MovieDetailView()
    }

}
