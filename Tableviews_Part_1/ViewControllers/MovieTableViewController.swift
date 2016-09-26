//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    enum Genre: Int {
        case animation
        case action
        case drama
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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return movieData?.count ?? 0
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        guard  let data = movieData else {
//            return cell
//        }
//        cell.textLabel?.text = movieData?[indexPath.row].title
//        cell.detailTextLabel?.text = String(data[indexPath.row].year)
//        
//        return cell
//    }
    
 
 override func numberOfSections(in tableView: UITableView) -> Int {
 return 3
 }
 
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
 else {
 return 0
 }
    
 
//     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//     guard let year = Year.init(rawValue: section), let data = byYear(year)
//     else {
//     return 0
    
 
 
 return data.count
 }
 
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
 
 guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
 else {
 return cell
 }
    
    
//     guard let year = Year.init(rawValue: indexPath.section), let data = byYear(year)
//     else {
//     return cell
//     }
    
 
 cell.textLabel?.text = data[indexPath.row].title
 cell.detailTextLabel?.text = String(data[indexPath.row].year)
 
 return cell
 }
 
 override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
 guard let genre = Genre.init(rawValue: section) else { return "" }
 
 switch genre {
 case .action:
 return "Action"
 case .animation:
 return "Animation"
 case .drama:
 return "Drama"
 }
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
    
   // /*
     
    
    func yeartableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let year = Year.init(rawValue: section) else { return "" }
        
        enum Year {
            case CenturyTwenty, CenturyTwentyOne
        
     
     switch year {
        case .CenturyTwenty:
            return "20th Century"
        case .CenturyTwentyOne:
            return "21st Century"
        }
    }
    
    
     func byCentury(_ year: Year) -> [Movie]? {
     let filter: (Movie) -> Bool
     switch year {
     case .CenturyTwenty:
        filter = { (a) -> Bool in
            a.year < 2000
        }
     case .CenturyTwentyOne:
        filter = { (a) -> Bool in
            a.year >= 2000
        }
     }
     }
    }
}
