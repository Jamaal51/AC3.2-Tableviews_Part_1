//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    var test = false
    
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    
    enum Century: Int {
        case twenty
        case twentyfirst
    }
    
    
    func byYear(_ year: Century) -> [Movie]? {
        let newFilter: (Movie) -> Bool
        switch year {
        case .twenty:
            newFilter = { (a) -> Bool in
                a.year < 2000
            }
        case .twentyfirst:
            newFilter = { (a) -> Bool in
                a.year > 2000
            }
        }
        let newestFilter = movieData?.filter(newFilter).sorted { $0.year < $1.year}
        return newestFilter
    }
    
    func byGenre(_ genre: Genre) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch genre {
        case .action:
            filter = { (a) -> Bool in
                a.genre == "action"
            }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation"
            }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama"
            }
            
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        return filtered
    }
    
    internal var movieData: [Movie]?

    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.tableView.backgroundColor = UIColor.blue
        
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if test {
        return 2
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if test{
        guard let year = Century.init(rawValue: section), let newData = byYear(year)
            else {
                return 0
        }
            
            return newData.count
        }
        else {
        guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
            else {
                return 0
            }
            
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if test {
            guard let year = Century.init(rawValue: indexPath.section), let newData = byYear(year)
                else {
                    return cell
            }
            
            cell.textLabel?.text = newData[indexPath.row].title
            cell.detailTextLabel?.text = String(newData[indexPath.row].year)
            
            return cell
            
        }
        else {
            guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
                else {
                    return cell
            }
            
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let genre = Genre.init(rawValue: section) else { return "" }
        
        if !test {
            switch genre {
            case .action:
                return "Action"
            case .animation:
                return "Animation"
            case .drama:
                return "Drama"
            }
        }
        else {
            guard let year = Century.init(rawValue: section) else { return ""}
            
            switch year {
            case .twenty:
                return "20th Century"
            case .twentyfirst:
                return "21st Century"
            }
        }
        
}
}
