//
//  GADemoTests.swift
//  GADemoTests
//
//  Created by BMGH SRL on 29/09/2018.
//  Copyright © 2018 BMAGH. All rights reserved.
//

import XCTest
@testable import GADemo

class GADemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetMoviesNowPlaying() {
        let service = API
        if let _token = Bundle.main.infoDictionary!["Token"] as? String {
            API.Token = _token
        }
        
        let _expectation = expectation(description: "Get list of movies now playing")
        
        service.getMoviesNowPlaying(pageNumber: "1")
            .load()
            .onSuccess { (response) in
                
                guard let jsonData = response.content as? Data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: jsonData)
                    print(movies.totalResults)
                } catch let error {
                    print(error)
                }
                
 
                XCTAssert(true)
                
                _expectation.fulfill()
            }.onFailure { (error) in
                print(error)
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testQueryMoviesDatabase() {
        let service = API
        if let _token = Bundle.main.infoDictionary!["Token"] as? String {
            API.Token = _token
        }
        
        let _expectation = expectation(description: "Get list of movies matching query")
        
        service.searchMovies(with: "terminator", pageNumber: "1")
            .load()
            .onSuccess { (response) in
                
                guard let jsonData = response.content as? Data else {
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: jsonData)
                    print(movies.totalResults)
                } catch let error {
                    print(error)
                }
                
                
                XCTAssert(true)
                
                _expectation.fulfill()
            }.onFailure { (error) in
                print(error)
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    

}
