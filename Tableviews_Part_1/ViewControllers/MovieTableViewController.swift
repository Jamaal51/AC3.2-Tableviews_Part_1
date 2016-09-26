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
	let displayType = DisplayBy.century // choose either century or genre
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Movies"
		self.tableView.backgroundColor = .orange
		
		// converting from array of dictionaries
		// to an array of Movie structs
		var movieContainer: [Movie] = []
		for rawMovie in rawMovieData {
			movieContainer.append(Movie(from: rawMovie))
		}
		movieData = movieContainer
	}
	
	// MARK: - Table view data source
	enum Century: Int {
		case century20
		case century21
	}
	
	enum Genre: Int {
		case animation
		case action
		case drama
	}
	
	enum DisplayBy {
		case century
		case genre
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		switch displayType {
		case .century:
		return 2
		case .genre:
		return 3
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch displayType {
		case .century:
			guard let century = Century.init(rawValue: section), let data = byCentury(century)
				else {
					return 0
			}
			return data.count
		case .genre:
			guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
				else {
					return 0
			}
			return data.count
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
		switch displayType {
		case .century:
			guard let century = Century.init(rawValue: indexPath.section), let data = byCentury(century) else { return cell }
			cell.textLabel?.text = data[indexPath.row].title
			cell.detailTextLabel?.text = String(data[indexPath.row].year)
			return cell
		case .genre:
		guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre) else { return cell }
		cell.textLabel?.text = data[indexPath.row].title
		cell.detailTextLabel?.text = String(data[indexPath.row].year)
		return cell
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch displayType{
		case .century:
			guard let century = Century.init(rawValue: section) else { return "" }
			switch century {
			case .century20:
				return "20th Century"
			case .century21:
				return "21st Century"
			}
		case .genre:
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
	
	// MARK: - Other Stuff
	func byCentury(_ century: Century) -> [Movie]? {
		let filter: (Movie) -> Bool
		switch century {
		case .century20:
			filter = { (a) -> Bool in
				a.year < 2001
			}
		case .century21:
			filter = { (a) -> Bool in
				a.year >= 2001
			}
		}
		// after filtering, sort
		let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
		return filtered
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
		let filtered = movieData?.filter(filter).sorted { $0.year < $1.year }
		return filtered
	}
}
