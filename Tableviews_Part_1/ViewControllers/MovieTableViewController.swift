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
        
        static let count = 3
    }
    
    enum Century: Int{
        case twentythCentury
        case twentyFirst
        
        static let count = 2
    }
    
    
    @IBOutlet weak var toggleView: UISwitch!
    
    internal var movieData: [Movie]?
    
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    var numberOfSections = Century.count
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        self.tableView.backgroundColor = UIColor.blue
        toggleView.setOn(false, animated: true)
        
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
        
        return self.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if toggleView.isOn{
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
            }
            
            return data.count
        }
        else{
            guard let year = Century.init(rawValue: section), let data = byYear(year)
                else {
                    return 0
            }
            
            return data.count
            
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if toggleView.isOn{
            guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
                else {
                    return cell
            }
            
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            
            return cell
        }else{
            
            guard let century = Century.init(rawValue: indexPath.section), let data = byYear(century)
                else {
                    return cell
            }
            
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if toggleView.isOn{
            
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
        else{
            
            guard let year = Century.init(rawValue: section) else { return "" }
            
            switch year {
            case .twentyFirst:
                return "21st Century"
            case .twentythCentury:
                return "20st Century"
                
            }
            
            
        }
        
    }
    
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return Century.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        guard let year = Century.init(rawValue: section), let data = byYear(year)
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
    //        guard let century = Century.init(rawValue: indexPath.section), let data = byYear(century)
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
    //        guard let year = Century.init(rawValue: section) else { return "" }
    //
    //        switch year {
    //        case .twentyFirst:
    //            return "21st Century"
    //        case .twentythCentury:
    //            return "20st Century"
    //
    //        }
    //
    //    }
    
    
    @IBAction func changeView(_ sender: UISwitch) {
        
        let test = toggleSwitch(switchState: sender.isOn)
        
        if test{
            self.numberOfSections = Genre.count
        }else{
            self.numberOfSections = Century.count
        }
        
        reloadTable()
        
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
    
    
    func byYear(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .twentyFirst:
            filter = { (a) -> Bool in
                a.year > 2000            }
        case .twentythCentury:
            filter = { (a) -> Bool in
                a.year <= 2000
            }
            
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }
    
    
    
    //reload table view
    func reloadTable(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
            print("table reload")
        }
    }
    
    func toggleSwitch(switchState:Bool)->Bool{
        print(switchState)
        return switchState
    }
    
}
