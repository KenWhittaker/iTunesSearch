//
//  iTunesDataTests.swift
//  iTunesDataTests
//
//  Created by Ken Whittaker on 8/19/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

// Reference: https://www.raywenderlich.com/150073/ios-unit-testing-and-ui-testing-tutorial

import XCTest
@testable import iTunesSearch
import SwiftyJSON

class iTunesDataTests: XCTestCase {
    
    let sampleString = "{\"resultCount\": 50, \"results\": [{ \"wrapperType\": \"track\",\"kind\": \"song\",\"artistId\": 909253,\"collectionId\": 879273552,\"trackId\": 879273565,\"artistName\": \"Jack Johnson\",\"collectionName\": \"In Between Dreams\",\"trackName\": \"Better Together\",\"collectionCensoredName\": \"In Between Dreams\",\"trackCensoredName\": \"Better Together\",\"artistViewUrl\": \"https://itunes.apple.com/us/artist/jack-johnson/id909253?uo=4\",\"collectionViewUrl\": \"https://itunes.apple.com/us/album/better-together/id879273552?i=879273565&uo=4\",\"trackViewUrl\": \"https://itunes.apple.com/us/album/better-together/id879273552?i=879273565&uo=4\",\"previewUrl\": \"http://a25.phobos.apple.com/us/r30/Music6/v4/13/22/67/1322678b-e40d-fb4d-8d9b-3268fe03b000/mzaf_8818596367816221008.plus.aac.p.m4a\",\"artworkUrl30\": \"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/30x30bb.jpg\",\"artworkUrl60\": \"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/60x60bb.jpg\",\"artworkUrl100\": \"http://is1.mzstatic.com/image/thumb/Music2/v4/a2/66/32/a2663205-663c-8301-eec7-57937c2d0878/source/100x100bb.jpg\",\"collectionPrice\": 8.99,\"trackPrice\": 1.29,\"releaseDate\": \"2005-03-01T08:00:00Z\",\"collectionExplicitness\": \"notExplicit\",\"trackExplicitness\": \"notExplicit\",\"discCount\": 1,\"discNumber\": 1,\"trackCount\": 15,\"trackNumber\": 1,\"trackTimeMillis\": 207679,\"country\": \"USA\",\"currency\": \"USD\",\"primaryGenreName\": \"Rock\",\"isStreamable\": true}]}"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testParse() {
        
        let promise = expectation(description: "Contains JSON with trackName, kind, trackPrice, and artwork60")
        
        let sampleJSON = JSON.parse(sampleString)
        
        if let results = sampleJSON["results"].array {
            
            if results.count > 0 {
                
                let resultSample = results.first
                
                if let _ = resultSample?[Constants.keys.trackName], let _ = resultSample?[Constants.keys.kind], let _ = resultSample?[Constants.keys.trackPrice], let _ = resultSample?[Constants.keys.artwork60] {
                    
                    promise.fulfill()
                    
                } else {
                    
                    XCTFail("Missing JSON Key(s)")
                }
                
            } else {
                
                XCTFail("Invalid JSON")
            }
            
        } else {
            
            XCTFail("Invalid JSON")
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
