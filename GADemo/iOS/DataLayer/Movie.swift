//
//  Movie.swift
//  GADemo
//
//  Created by BMGH SRL on 30/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    public let voteCount: Int?
    public let id: Int?
    public let video: Bool?
    public let voteAverage: Double?
    public let title: String?
    public let popularity: Double?
    public let posterPath: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let genreIDS: [Int]?
    public let backdropPath: String?
    public let adult: Bool?
    public let overview: String?
    public let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    public init(voteCount: Int?, id: Int?, video: Bool?, voteAverage: Double?, title: String?, popularity: Double?, posterPath: String?, originalLanguage: String?, originalTitle: String?, genreIDS: [Int]?, backdropPath: String?, adult: Bool?, overview: String?, releaseDate: String?) {
        self.voteCount = voteCount
        self.id = id
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.backdropPath = backdropPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    //base_url, a file_size and a file_path.
    
    func imagePath(size: String = "original") -> String {
        if let _backdropPath = self.backdropPath {
            return "https://image.tmdb.org/t/p/original\(_backdropPath)"
        }
        return ""
    }
    
}
