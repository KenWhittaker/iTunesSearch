//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

// Reference: https://www.raywenderlich.com/150073/ios-unit-testing-and-ui-testing-tutorial

import XCTest
@testable import iTunesSearch

class iTunesAPITests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testAPIRequest() {
        
        let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&entity=song")!
        
        let request = NSMutableURLRequest(url: url)
        
        let promise = expectation(description: "Status code success")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: request as URLRequest) { data, response, error in
            
            if let error = error {
                
                responseError = error
                
                XCTFail("Error: \(error.localizedDescription)")
                return
                
            } else if data != nil {
                
                statusCode = (response as? HTTPURLResponse)?.statusCode
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    
                    promise.fulfill()
                    
                } else {
                    
                    XCTFail("Status code fail")
                }
                
            } else {
                
                XCTFail("Request fail")
            }
        }
        
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
