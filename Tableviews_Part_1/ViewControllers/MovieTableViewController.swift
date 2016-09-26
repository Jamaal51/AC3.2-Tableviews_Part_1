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
        case twentieth
        case twentyfirst
    }
    enum sections {
        case byGenre
        case byCentury
        
    }
    
    var display = sections.byGenre
    
    
    internal var movieData: [Movie]?

    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.tableView.backgroundColor = UIColor.cyan
        switchingDisplay.setTitle("Century", for: .normal)
   
        
        
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
            filter = { (a) -> Bool in a.genre == "action"}
        case .animation:
            filter = { (a) -> Bool in a.genre == "animation"}
        case .drama:
            filter = { (a) -> Bool in a.genre == "drama"}
            
        }
        
        // after filtering, sort
        
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }
    
    func byCentury(_ century:Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .twentieth:
            filter = { (a) -> Bool in a.year < 2000 }
        case .twentyfirst:
            filter = { (a) -> Bool in a.year >= 2000 }
        }
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        return filtered
    
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        switch display {
        case .byGenre:
            return 8
        case .byCentury:
            return 2
        
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch display {
            
        case .byGenre:
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
                    
            }
            
            return data.count
        
        case .byCentury:
        guard let cent = Century.init(rawValue: section), let data = byCentury(cent)
        else {
            return 0
        }
        return data.count
            
            }
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch display {
        
        case.byGenre:
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
            
        case.byCentury:
            
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cent = Century.init(rawValue: indexPath.section), let data = byCentury(cent)
        
        else {
            return cell
        }
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = "\(String(data[indexPath.row].year)), \(data[indexPath.row].genre.capitalized)"
        return cell
        
    
    }
}
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch display {
            
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
        
        case.byCentury:
            guard let cent = Century.init(rawValue: section) else { return "" }
            switch cent {
            case .twentieth:
                return "20th Century"
            case .twentyfirst:
                return "21st Century"
            }
    }
}
    @IBOutlet weak var switchingDisplay: UIButton!
    
    @IBAction func switchingDisplay(_ sender: UIButton) {
        switch display {
        case .byCentury:
            display = .byGenre
            switchingDisplay.setTitle("Display by Genre", for: .normal)
        case .byGenre:
            display = .byCentury
            switchingDisplay.setTitle("Display by Title", for: .normal)
        }
        
        self.tableView.reloadData()
    }
}


