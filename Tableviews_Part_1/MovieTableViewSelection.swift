//
//  MovieTableViewControllerSelection.swift
//  Tableviews_Part_1
//
//  Created by Ana Ma on 9/25/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

//
//  MovieTableViewControllerSelection.swift
//  Tableviews_Part_1
//
//  Created by Ana Ma on 9/25/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit
class MovieTableViewSelection: UITableViewController {
    
    var organizeMethodBy = ["Genre", "Century"]
    
    internal var movieData: [Movie]?
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCellSelection"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.white
        
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizeMethodBy.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = organizeMethodBy[indexPath.row]
        
        return cell
    }
    
    //Reference https://www.youtube.com/watch?v=peSXZi_nxek#t=18.397143
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "orderByGenre", sender:organizeMethodBy[0])
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "orderByCentury", sender:organizeMethodBy[1])
        } else {
            performSegue(withIdentifier: "orderByCentury", sender:organizeMethodBy[1])        }
        
    }
    
}
