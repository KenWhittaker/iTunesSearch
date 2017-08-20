//
//  EntityTableViewController.swift
//  iTunesSearch
//
//  Created by Ken Whittaker on 8/18/17.
//  Copyright © 2017 kwhittaker. All rights reserved.
//

import UIKit

class EntityTableViewController: UITableViewController {
    
    var entities = [["All" : "allTrack"],
                    ["Audiobook" : "audiobook"],
                    ["eBook" : "ebook"],
                    ["Movie" : "movie"],
                    ["Music Video" : "musicVideo"],
                    ["Podcast" : "podcast"],
                    ["Short Film" : "shortFilm"],
                    ["Software" : "software"],
                    ["Song" : "song"],
                    ["Track" : "musicTrack"],
                    ["TV Show" : "tvSeason"]]

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifiers.entityCell, for: indexPath)
        
        cell.textLabel?.text = entities[indexPath.row].keys.first

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEntity = entities[indexPath.row].values.first!
        
        let searchViewController = self.navigationController?.viewControllers[0] as! SearchViewController
        searchViewController.selectedEntity = selectedEntity
        self.navigationController?.popViewController(animated: true)
    }
}
