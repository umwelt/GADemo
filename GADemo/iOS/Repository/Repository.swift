//
//  Repository.swift
//  GADemo
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import Foundation

class Repository: NSObject {
    
    override init() {
    }
    
    
    /// Movies now playing
    ///
    /// - Parameters:
    ///   - pageNumber: String
    ///   - completion: Movies || Error
    func getMoviesNowPlaying(pageNumber: String, completion: @escaping (Movies?, Error?) -> Void) {
        
        API.getMoviesNowPlaying(pageNumber: pageNumber)
            .load()
            .onSuccess { (response) in
            
            guard let jsonData = response.content as? Data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(Movies.self, from: jsonData)
                completion(movies, nil)
            } catch let error {
                completion(nil, error)
            }
            
            }.onFailure { (error) in
                // Report Error
                completion(nil, error)
        }
    }
    
    
    func searchMovie(with query: String, completion: @escaping (Movies?, Error?) -> Void) {
        
        API.searchMovies(with: query)
            .load()
            .onSuccess { (response) in
                
                guard let jsonData = response.content as? Data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: jsonData)
                    completion(movies, nil)
                } catch let error {
                    completion(nil, error)
                }
                
                
            
            }.onFailure { (error) in
                
        }
        
    }
    
}
