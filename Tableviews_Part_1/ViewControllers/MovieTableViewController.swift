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
    
    enum Century: Int {
        case twentiethCentury
        case twentyFirstCentury
    }
    
    enum State {
        case byCentury
        case byGenre
    }
    
    internal var buttonSwitch: State = .byGenre
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
        switch buttonSwitch {
        case .byCentury:
            return 2
        case .byGenre:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch buttonSwitch {
        case .byCentury:
            guard let century = Century.init(rawValue: section), let data = byCentury(century)
            else {
                return 0
        }
            return data.count
        case .byGenre:
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
            }
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        switch buttonSwitch {
        case .byCentury:
            guard let century = Century.init(rawValue: indexPath.section), let data = byCentury(century)
                else {
                    return cell
            }
            
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            
            return cell
        
        case .byGenre:
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
        switch buttonSwitch {
        case .byCentury:
            guard let century = Century.init(rawValue: section) else { return "" }
            switch century {
            case .twentiethCentury:
                return "20th Century"
            case .twentyFirstCentury:
                return "21st Century"
            }

        case .byGenre:
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
    
    // Filter and then sort by century
    func byCentury(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .twentiethCentury:
            filter = { (a) -> Bool in
                a.year <= 2000
            }
        case .twentyFirstCentury:
            filter = { (a) -> Bool in
                a.year > 2000
            }
        }
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        
        return filtered
    }

    @IBAction func switchViews(_ sender: UIButton) {
        if buttonSwitch == .byGenre {
            buttonSwitch = .byCentury
            switchState.setTitle("Filter by Genre", for: .normal)
        }
        else {
            buttonSwitch = .byGenre
            switchState.setTitle("Filter by Century", for: .normal)
        }
        self.tableView.reloadData()
    }
    
    @IBOutlet weak var switchState: UIButton!

}
