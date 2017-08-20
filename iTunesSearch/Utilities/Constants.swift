//
//  Constants.swift
//  iTunesSearch
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

struct Constants {
    
    struct urls {
        
        static let base = "https://itunes.apple.com"
    }
    
    struct routes {
        static let path = "/search"
    }
    
    struct keys {
        
        static let results = "results"
        static let errorMessage = "errorMessage"
        
        static let artwork60 = "artworkUrl60"
        static let artwork100 = "artworkUrl100"
        static let trackName = "trackName"
        static let kind = "kind"
        static let trackPrice = "trackPrice"
        static let description = "description"
    }
    
    struct cellIdentifiers {
        
        static let trackCell = "trackCell"
        static let entityCell = "entityCell"
    }
    
}
