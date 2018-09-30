//
//  Movies.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation
//
//   let movies = try? newJSONDecoder().decode(Movies.self, from: jsonData)

public struct Movies: Codable {
    public let results: [Movie]?
    public let page: Int?
    public let totalResults: Int?
    public let dates: Dates?
    public let totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case page = "page"
        case totalResults = "total_results"
        case dates = "dates"
        case totalPages = "total_pages"
    }
    
    public init(results: [Movie]?, page: Int?, totalResults: Int?, dates: Dates?, totalPages: Int?) {
        self.results = results
        self.page = page
        self.totalResults = totalResults
        self.dates = dates
        self.totalPages = totalPages
    }
    
  
}



