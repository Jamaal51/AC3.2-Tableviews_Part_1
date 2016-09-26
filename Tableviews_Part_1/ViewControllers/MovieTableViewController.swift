//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
//    enum Genre: Int {
//        case animation
//        case action
//        case drama
//    }
    //https://spin.atomicobject.com/2015/09/02/switch-container-views/
    //Couldn't get this switch container view to work

    @IBAction func Switch(_ sender: UISwitch) {
        
    }
    enum Century: Int {
        case twentieth
        case twentyFirst
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
    
//    func byGenre(_ genre: Genre) -> [Movie]? {
//        let filter: (Movie) -> Bool
//        switch genre {
//        case .action:
//            filter = { (a) -> Bool in
//                a.genre == "action"
//            }
//        case .animation:
//            filter = { (a) -> Bool in
//                a.genre == "animation"
//            }
//        case .drama:
//            filter = { (a) -> Bool in
//                a.genre == "drama"
//            }
//            
//        }
//        
//        // after filtering, sort
//        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
//        
//        return filtered
//    }
    
    func byYear(_ year: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch year {
        case .twentieth:
            filter = { (a) -> Bool in
                a.year < 2000
            }
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year > 1999
            }

        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }

    


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
//            else {
//                return 0
//        }
//        
//        return data.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        
//        guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
//            else {
//                return cell
//        }
//        
//        cell.textLabel?.text = data[indexPath.row].title
//        cell.detailTextLabel?.text = String(data[indexPath.row].year)
//        
//        return cell
//    }
//    
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
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let year = Century.init(rawValue: section), let data = byYear(year)
            else {
                return 0
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let year = Century.init(rawValue: indexPath.section), let data = byYear(year)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let year = Century.init(rawValue: section) else { return "" }
        
        switch year {
        case .twentieth:
            return "20th Century"
        case .twentyFirst:
            return "21st Century"
        }
}
}
