//
//  MovieCollectionViewCell.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deployLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deployLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
    }
    
    private func deployLayout(){
        
        addSubview(movieImage)
        movieImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(contentView.snp.width)
        }
    }
    
    
    func with(_ movie: Movie) {
        if let _url = URL(string: movie.imagePath()) {
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: _url)
        } else {
            movieImage.image = UIImage(named: "placeholder")
        }
    }
    
}
