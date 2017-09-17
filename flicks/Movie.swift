//
//  Movie.swift
//  flicks
//
//  Created by dawei_wang on 9/16/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    let POSTER_BASE_URL = "https://image.tmdb.org/t/p/w342"
    let HIGH_RESOLUTION_POSTER_BASE_URL = "https://image.tmdb.org/t/p/original"
    let LOW_RESOLUTION_POSTER_BASE_URL = "https://image.tmdb.org/t/p/w45"
    
    fileprivate(set) var title : String
    fileprivate(set) var overview : String
    fileprivate(set) var posterPath : String?
    fileprivate(set) var voteAverage : Float
    fileprivate(set) var isAdult : Bool
    fileprivate(set) var releaseDateString : String
    
    var posterUrl : URL? {
        get {
            return posterPath.map({ (path: String) -> URL in
                URL(string: POSTER_BASE_URL + path)!
            })
        }
    }
    
    var lowResolutionPosterUrl : URL? {
        get {
            return posterPath.map({ (path: String) -> URL in
                URL(string: LOW_RESOLUTION_POSTER_BASE_URL + path)!
            })
        }
    }
    
    var hiResolutionPosterUrl : URL? {
        get {
            return posterPath.map({ (path: String) -> URL in
                URL(string: HIGH_RESOLUTION_POSTER_BASE_URL + path)!
            })
        }
    }
    
    var voteString : String {
        get {
            return "\(voteAverage)"
        }
    }
    
    init(overview: String, title: String, posterPath: String?, voteAverage: Float, releaseDateString: String, isAdult: Bool) {
        self.overview = overview
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.releaseDateString = releaseDateString
        self.isAdult = isAdult
    }
    
    class func getMovies(_ json: JSON) -> [Movie] {
        var movies = [Movie]()
        if let movieArray = json["results"].array {
            for movie in movieArray {
                let title = movie["title"].string!
                let overview = movie["overview"].string!
                let posterPath = movie["poster_path"].string
                let voteAverage = movie["vote_average"].float!
                let releaseDateString = movie["release_date"].string!
                let isAdult = movie["adult"].bool!
                
                movies.append(Movie(overview: overview, title: title, posterPath: posterPath, voteAverage: voteAverage, releaseDateString: releaseDateString, isAdult: isAdult));
            }
        }
        return movies
    }
}
