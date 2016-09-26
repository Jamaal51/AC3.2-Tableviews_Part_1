//
//  MovieTableViewByCentury.swift
//  Tableviews_Part_1
//
//  Created by Ana Ma on 9/25/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

//
//  MovieTableViewControllerByCentury.swift
//  Tableviews_Part_1
//
//  Created by Ana Ma on 9/25/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewControllerByCentury: UITableViewController {
    
    enum Century: Int {
        case twentiethCenytury
        case twentyfirstCentury
    }
    
    internal var movieData: [Movie]?
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCellByCentury"
    
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
    
    //MARK: - Filter movie by century function
    func byCentury(_ century: Century) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch century {
        case .twentiethCenytury:
            filter = { (a) -> Bool in
                a.year - 1900 < 100
            }
        case .twentyfirstCentury:
            filter = { (a) -> Bool in
                a.year - 2000 < 100 && a.year - 2000 > 0
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let century = Century.init(rawValue: section), let data = byCentury(century)
            else {
                return 0
        }
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let century = Century.init(rawValue: indexPath.section), let data = byCentury(century)
            else {
                return cell
        }
        
        cell.textLabel?.text = data[indexPath.row].title
        cell.detailTextLabel?.text = String(data[indexPath.row].year)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let century = Century.init(rawValue: section) else { return "" }
        
        switch century {
        case .twentiethCenytury:
            return "20th Century"
        case .twentyfirstCentury:
            return "21st Century"
        }
    }
    
}

