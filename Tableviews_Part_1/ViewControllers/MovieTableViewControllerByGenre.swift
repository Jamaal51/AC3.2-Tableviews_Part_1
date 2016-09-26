//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewControllerByGenre: UITableViewController {
    
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    
    internal var movieData: [Movie]?

    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCellByGenre"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.title = "Movies"
        self.tableView.backgroundColor = UIColor.white
        
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
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


    // MARK: - Table view data source
    //The main assignment is to rework the table to have two sections: 20th Century and 21st Century using the mechanisms illustrated by the genre exercise above.
    //As a bonus, make your project include the option to section by Genre or Century. This might be easier (and would be fine) if your code required only a small change and a recompile (i.e. no run-time switchability).
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
            else {
                return 0
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
            else {
                return cell
        }
        
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
    
}
