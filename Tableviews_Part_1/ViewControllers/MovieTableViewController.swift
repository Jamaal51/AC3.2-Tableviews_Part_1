//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
<<<<<<< HEAD
//  Created by Jason Gresh on 9/22/16.
=======
//  Created by Harichandan Singh on 9/22/16.
>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
<<<<<<< HEAD
    
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    
    enum Century: Int {
        case twentieth
        case twentyfirst
    }
    
    // choose either "genre" or "century" to output different table view with corresponding rows and details
    var genreOrCentury = "genre"
    
    internal var movieData: [Movie]?
    
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
=======
    internal var movieData: [Movie]?
    internal let rawMovieData: [[String: Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"

>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
<<<<<<< HEAD
        self.tableView.backgroundColor = UIColor.blue
        
        // converting from array of dictionaries
        // to an array of Movie structs
=======
        self.tableView.backgroundColor = .blue
        
        //converting from array of dictionaries to an array of Movie structs
>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
<<<<<<< HEAD
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
    
    func byCentury(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .twentieth:
            filter = { (a) -> Bool in
                a.year < 2000
            }
        case .twentyfirst:
            filter = { (a) -> Bool in
                a.year >= 2000
            }
        }
        
        // after filtering, sort
        let filteredByCentury = movieData?.filter(filter).sorted {$0.year < $1.year}
        
        return filteredByCentury
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = 1
        if genreOrCentury == "genre" {
            numberOfSections = 3
        }
        else if genreOrCentury == "century" {
            numberOfSections = 2
        }
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if genreOrCentury == "genre" {
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
            }
            rowCount = data.count
        }
        else if genreOrCentury == "century" {
            guard let century = Century.init(rawValue: section), let data = byCentury(century)
                else {
                    return 0
            }
            rowCount = data.count
        }
        return rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var movieArray = [Movie]()
        
        if genreOrCentury == "genre" {
            guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
                else {
                    return cell
            }
            movieArray = data
        }
        else if genreOrCentury == "century" {
            guard let century = Century.init(rawValue: indexPath.section), let data = byCentury(century)
                else {
                    return cell
            }
            movieArray = data
        }
        
        cell.textLabel?.text = movieArray[indexPath.row].title
        cell.detailTextLabel?.text = String(movieArray[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var stringForSection = String()
        if genreOrCentury == "genre" {
            guard let genre = Genre.init(rawValue: section) else { return "" }
            
            switch genre {
            case .action:
                stringForSection = "Action"
            case .animation:
                stringForSection = "Animation"
            case .drama:
                stringForSection = "Drama"
            }
        }
        else if genreOrCentury == "century" {
            guard let century = Century.init(rawValue: section) else { return "" }
            
            switch century {
            case .twentieth:
                stringForSection = "20th Century"
            case .twentyfirst:
                stringForSection = "21st Century"
            }
        }
        return stringForSection
    }
}

=======
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
>>>>>>> 338b20fedb9179bc195ccc634f30fc4f21719001
