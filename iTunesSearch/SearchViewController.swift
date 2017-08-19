//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [JSON]()
    var selectedEntity = "allTrack"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (searchBar.text?.characters.count)! > 0 {
            search()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            selectedEntity = "allTrack"
            search()
            break;
        case 1:
            selectedEntity = "album"
            search()
            break;
        case 2:
            selectedEntity = "audiobook"
            search()
            break;
        case 3:
            selectedEntity = "podcast"
            search()
            break;
        default:
            performSegue(withIdentifier: "chooseEntity", sender: sender)
            break;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackTableViewCell
        
        let result = searchResults[indexPath.row]
        
        let url = URL(string: result["artworkUrl60"].stringValue)!
        cell.trackImageView.kf.setImage(with: url)
        
        cell.trackNameLabel.text = result["trackName"].stringValue
        cell.kindLabel.text = result["kind"].stringValue
        cell.trackPriceLabel.text = "$\(result["trackPrice"].stringValue)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackTableViewCell
        cell.imageView?.kf.cancelDownloadTask()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        search()
    }
    
    func search() {
        
        if ((searchBar.text?.characters.count)! > 0) {
        
            APIManager().search(term: searchBar.text!, entity: selectedEntity) { (success, results) in
                
                if success {
                    
                    self.searchResults.removeAll()
                    
                    print(results!)
                    
                    for item in results! {
                        self.searchResults.append(item.1)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTrackDetail" {
        
            let trackDetailViewController: TrackDetailViewController = segue.destination as! TrackDetailViewController
        
            if let indexPath = tableView.indexPathForSelectedRow {
                
                trackDetailViewController.result = self.searchResults[indexPath.row]
            }
            
        } else if segue.identifier == "chooseEntity" {
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

