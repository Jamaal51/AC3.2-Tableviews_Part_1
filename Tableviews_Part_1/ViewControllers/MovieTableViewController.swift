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
    
    enum Genre: Int {
        case animation
        case action
        case drama
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
    
    enum Century: Int {
        case twenty
        case twentyFirst
    }
    
    func byCentury(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century  {
        case .twenty:
            filter = { (a) -> Bool in
                a.year / 100 == 19
            }
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year / 100 == 20
            }
        }
        
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        return filtered
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let year = Century.init(rawValue: section), let data = byCentury(year)
        //guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
            else {
                return 0
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        //guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
        guard let year = Century.init(rawValue: indexPath.section), let data = byCentury(year)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let genre = Genre.init(rawValue: section) else { return "" }
//        
//        switch genre {
//        case .action:
//            return "Action"
//        case .animation:
//            return "Animation"
//        case .drama:
//            return "Drama"
//        }
//    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let century = Century.init(rawValue: section) else { return "" }
        
        switch century {
        case .twenty:
            return "Twentieth Century"
        case .twentyFirst:
            return "Twenty First Century"
        }
        
//        switch genre {
//        case .action:
//            return "Action"
//        case .animation:
//            return "Animation"
//        case .drama:
//            return "Drama"
//        }
    }
}
