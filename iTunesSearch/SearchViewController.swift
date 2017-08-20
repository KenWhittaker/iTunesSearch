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
    @IBOutlet weak var noResultsLabel: UILabel!
    
    var searchResults = [JSON]()
    var selectedEntity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        search()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    @IBAction func selectSegment(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            selectedEntity = ""
            search()
            break;
        case 1:
            selectedEntity = "song"
            search()
            break;
        case 2:
            selectedEntity = "movie"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.trackCell, for: indexPath) as! TrackTableViewCell
        
        let result = searchResults[indexPath.row]
        
        let url = URL(string: result[Constants.keys.artwork60].stringValue)!
        cell.trackImageView.kf.setImage(with: url)
        
        cell.trackNameLabel.text = result[Constants.keys.trackName].stringValue
        cell.kindLabel.text = result[Constants.keys.kind].stringValue
        
        var price = result[Constants.keys.trackPrice].stringValue
        price = formatCurrency(value: price)
        
        cell.trackPriceLabel.text = formatCurrency(value: price)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.trackCell) as! TrackTableViewCell
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
                    
                    if (results?.count)! > 0 {
                    
                        self.noResultsLabel.isHidden = true
                        
                        for item in results! {
                            
                            self.searchResults.append(item.1)
                        }
                        
                    } else {
                        
                        self.noResultsLabel.isHidden = false
                        self.noResultsLabel.text = "No results for \(String(describing: self.searchBar.text!))."
                    }
                    
                    self.tableView.reloadData()
                    
                } else {
                    
                    self.noResultsLabel.isHidden = false
                    self.noResultsLabel.text = "There was an error processing the search."
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
            
        }
    }
    
    func formatCurrency(value: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: Double(value)! as NSNumber)
        return result!
    }
}

