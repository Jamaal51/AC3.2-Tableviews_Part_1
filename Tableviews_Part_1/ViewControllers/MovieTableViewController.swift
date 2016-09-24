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
        case twentyFirst
    }
    
    enum sectionsBy {
        case filmGenre
        case filmCentury
        case filmTitle
    }
    
    var currentDisplayType = sectionsBy.filmGenre
    
    internal var movieData: [Movie]?

    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        switchDisplayLabel.setTitle("Display by Century", for: .normal)
        view.backgroundColor = UIColor.lightGray
        
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
                a.genre == "action" }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation" }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama" }
        }
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        return filtered         //sorted array, of movies of the same genre, by release year.
    }
    
    func byCentury(_ theCentury: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch theCentury {
        case .twentieth:
            filter = { (a) -> Bool in
                a.year < 2000 }
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year >= 2000 }
        }
        let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
        return filtered         //same^
    }
    
    func genreCounter() -> Int {
        guard let thisArrayOfMovies = movieData else { return 0 }
        var genreCount = 1
        var currentGenre = thisArrayOfMovies[0].genre
        for thisMovie in thisArrayOfMovies {
            if thisMovie.genre != currentGenre {
                currentGenre = thisMovie.genre
                genreCount += 1
            }
        }
        return genreCount
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        switch currentDisplayType {
        case .filmGenre:
            return genreCounter()
        case .filmCentury:
            return 2
        case .filmTitle:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentDisplayType {
        case .filmGenre:
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
            }
            return data.count
            
        case .filmCentury:
            guard let filmCent = Century.init(rawValue: section), let data = byCentury(filmCent)
                else {
                    return 0
            }
            return data.count
            
        case .filmTitle:
            guard let numMovies = movieData?.count else { return 0 }
            return numMovies
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentDisplayType {
        case .filmGenre:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
                else {
                    return cell
            }
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            return cell

        case .filmCentury:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            guard let filmCent = Century.init(rawValue: indexPath.section), let data = byCentury(filmCent)
                else {
                    return cell
            }
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = "\(String(data[indexPath.row].year)), \(data[indexPath.row].genre.capitalized)"
            return cell
        
        case .filmTitle:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            guard let data = movieData?.sorted(by: { (a, b) -> Bool in
                a.title < b.title  })
                else {
                    return cell
            }
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = "\(String(data[indexPath.row].year)), \(data[indexPath.row].genre.capitalized)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch currentDisplayType {
        case .filmGenre:
            guard let genre = Genre.init(rawValue: section) else { return "" }
            switch genre {
            case .action:
                return "Action"
            case .animation:
                return "Animation"
            case .drama:
                return "Drama"
            }
            
        case .filmCentury:
            guard let filmCent = Century.init(rawValue: section) else { return "" }
            switch filmCent {
            case .twentieth:
                return "20th Century"
            case .twentyFirst:
                return "21st Century"
            }
        case .filmTitle:
            return "A-Z"
        }
    }
    
    @IBOutlet weak var switchDisplayLabel: UIButton!
    
    @IBAction func switchDisplay(_ sender: UIButton) {
        switch currentDisplayType {
        case .filmCentury:
            currentDisplayType = .filmTitle
            switchDisplayLabel.setTitle("Display by Genre", for: .normal)
        case .filmGenre:
            currentDisplayType = .filmCentury
            switchDisplayLabel.setTitle("Display by Title", for: .normal)
        case .filmTitle:
            currentDisplayType = .filmGenre
            switchDisplayLabel.setTitle("Display by Century", for: .normal)
        }
        self.tableView.reloadData()
    }
}
