//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Harichandan Singh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    internal var movieData: [Movie]?
    internal let rawMovieData: [[String: Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        self.tableView.backgroundColor = .blue
        
        //converting from array of dictionaries to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
        dump(movieData)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return movieData?.count ?? 0
        }
        else if section == 1 {
            return 5
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = movieData![indexPath.row].title

        // Configure the cell...
        if indexPath.section == 0 {
            cell.contentView.backgroundColor = .blue
        }
        else {
            cell.contentView.backgroundColor = .green
        }
        return cell
    }
}
