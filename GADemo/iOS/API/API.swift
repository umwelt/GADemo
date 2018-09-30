//
//  API.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation
import Siesta


let API = _API()

class _API {
    
    let clientId = "WEB"
    
    var authHeader: String? {
        didSet {
            // Clear any cached data now that auth has changed
            service.wipeResources()
            
            // Force resources to recompute headers next time they’re fetched
            service.invalidateConfiguration()
        }
    }
    
    var Token: String? {
        didSet {
            if let _token = Token {
                queryToken = "?api_key=\(_token)"
            }
        }
    }
    
    var queryToken: String = ""
    
    // base url configuration so we can access end points by resource('')
    // Default networking handler URLSession with ephemeral session configurations
    private let service = Service (
        baseURL: Bundle.main.infoDictionary!["BASE_URL"] as! String,
        standardTransformers: [.text, .image]
    )
    
    init() {
        #if DEBUG
        //SiestaLog.Category.enabled = [.network, .networkDetails]
        SiestaLog.Category.enabled = .all
        #endif
    }
    
    
    /// Language and Region Parameters are optional and not used in
    /// the scope of this demo
    func getMoviesNowPlaying(pageNumber: String) -> Resource {
        guard let baseUrl = service.baseURL else { fatalError() }
        return service.resource(absoluteURL: "\(baseUrl)movie/now_playing\(queryToken)&language=en-US&page=\(pageNumber)")
    }
    
    /// https://api.themoviedb.org/3/search/movie?api_key=0a33c93cb136cdfb4dad1c5ea68e824f&language=en-US&query=nun&page=1&include_adult=false
    
    
    /// Query MovieDatabase with query
    ///
    /// - Parameters:
    ///   - query: String
    ///   - pageNumber: String
    /// - Returns: Movies
    func searchMovies(with query: String, pageNumber: String = "1") -> Resource {
        
        guard let baseUrl = service.baseURL else { fatalError() }
        return service.resource(absoluteURL: "\(baseUrl)search/movie\(queryToken)&language=en-US&query=\(query)&page=\(pageNumber)&include_adult=false")
        
    }
    

}
