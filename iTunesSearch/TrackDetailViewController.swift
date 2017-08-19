//
//  TrackDetailViewController.swift
//  iTunesSearch
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class TrackDetailViewController: UIViewController {
    
    var result: JSON = []

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: result["artworkUrl100"].stringValue)!
        trackImageView.kf.setImage(with: url)
        
        trackNameLabel.text = result["trackName"].stringValue
        descriptionLabel.text = result["description"].stringValue
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
