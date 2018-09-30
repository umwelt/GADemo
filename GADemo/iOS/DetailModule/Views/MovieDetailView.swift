//
//  MovieDetailView.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailView: UIView {
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        
        return imageView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.sizeToFit()
        label.text = "MOVIES"
        
        return label
    }()
    
    fileprivate lazy var moviePlot: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.black
        textView.textAlignment = .left
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textView.sizeToFit()
        
        return textView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deployLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deployLayout()
    }
    
    
    private func deployLayout() {
        
        backgroundColor = UIColor.black
        
        addSubview(movieImage)
        movieImage.snp.makeConstraints { (make) in
            make.top.equalTo(snp.topMargin)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(snp.width)
            make.height.equalTo(300)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(movieImage.snp.bottom).offset(16)
            make.height.equalTo(20)
        }
        
        addSubview(moviePlot)
        moviePlot.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width).offset(-32)
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(0)
        }
    
    }
    
    
    func with(_ movie: Movie) {
        
        if let _url = URL(string: movie.imagePath()) {
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: _url)
        } else {
            movieImage.image = UIImage(named: "placeholder")
        }
        
        if let _title = movie.originalTitle {
            titleLabel.text = _title
        }
        
        if let _plot = movie.overview {
            moviePlot.text = _plot
        }
    }
    
}
