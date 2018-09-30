//
//  MoviesCollectionView.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit
import SnapKit

class MoviesCollectionView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deployLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deployLayout()
    }
    
    
    /// Layout

    
    lazy var searchBar: SearchBar = {
        let searchBar = SearchBar()
        searchBar.tintColor = UIColor.white
        searchBar.backgroundColor = .black
        searchBar.searchBarStyle = .minimal
        searchBar.barStyle = UIBarStyle.black
        searchBar.keyboardAppearance = .dark
        searchBar.autocorrectionType = .yes
        searchBar.keyboardType = .asciiCapable
        searchBar.showsCancelButton = true
        searchBar.placeholder = "MOVIES"
        
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2), height: 250)
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = false
        
        return collectionView
    }()
    
    private func deployLayout(){
        
        backgroundColor = UIColor.black
        
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(snp.width)
            make.top.equalTo(snp.topMargin).offset(20)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width)
            make.left.equalTo(snp.left)
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.bottom.equalTo(0)
        }
        
    }
    
}
