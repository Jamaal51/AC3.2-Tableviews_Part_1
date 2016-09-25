//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    internal var movieData: [Movie]?
    
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
//    enum Genre: Int {
//        case animation
//        case action
//        case drama
//    }
    
    enum Century: Int {
        case TwentyFirstCentury
        case TwentyCentury
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        self.tableView.backgroundColor = UIColor.white
        
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
    }
    
    
    func byCentury(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .TwentyFirstCentury:
            filter = { (a) -> Bool in
                a.year > 2000
            }
        case .TwentyCentury:
            filter = { (a) -> Bool in
                a.year < 2000
            }
            
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $1.year < $0.year }
        
        return filtered
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let century = Century.init(rawValue: section), let data = byCentury(century)
            else {
                return 0
        }
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let century = Century.init(rawValue: indexPath.section), let data = byCentury(century)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let century = Century.init(rawValue: section) else { return "" }
        
        switch century {
        case .TwentyCentury:
            return "20th Century"
        case .TwentyFirstCentury:
            return "21st Century"
        }
    }
}
