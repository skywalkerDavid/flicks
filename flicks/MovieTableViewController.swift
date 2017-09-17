//
//  ViewController.swift
//  flicks
//
//  Created by dawei_wang on 9/12/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON
import MBProgressHUD

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tableview: UITableView!
    
    var movies: [Movie] = []
    var endpoint: String = "now_playing"
    var filteredMovies: [Movie]?
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = UIColor.rausch()
        
        // refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        let refreshTitleAttribute = [NSForegroundColorAttributeName: UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes:refreshTitleAttribute)
        refreshControl.backgroundColor = UIColor.babu()
        refreshControl.tintColor = UIColor.babu()

        // add refresh control to table view
        self.tableview.insertSubview(refreshControl, at: 0)
        
        // add search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        
        loadDataFromNetwork()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadDataFromNetwork()
        refreshControl.endRefreshing()
    }
    
    func loadDataFromNetwork() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string:"https://api.themoviedb.org/3/movie/\(self.endpoint)?api_key=\(apiKey)")
        var request = URLRequest(url: url!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                if let data = data {
                    self.movies = Movie.getMovies(JSON(data: data))
                    self.filteredMovies = self.movies
                    self.errorView.isHidden = true
                    self.tableview.reloadData()
                } else {
                    self.errorView.isHidden = false
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies?.count ?? 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableCell
        
        // set selection background
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.lightGray
        cell.selectedBackgroundView = backgroundView

        let movie = filteredMovies![indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredMovies = searchText.isEmpty ? movies : movies.filter({ (movie:Movie) -> Bool in
                movie.title.range(of: searchText, options: .caseInsensitive) != nil
            });
            tableview.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableview.indexPath(for: cell)
        let movie = filteredMovies![indexPath!.row]
        
        let detailsViewController = segue.destination as! DetailsViewController
        detailsViewController.movie = movie
    }
    
}

