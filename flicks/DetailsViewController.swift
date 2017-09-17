//
//  DetailsViewController.swift
//  flicks
//
//  Created by dawei_wang on 9/14/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var releaseDateView: UILabel!
    
    @IBOutlet weak var voteView: UILabel!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            overviewLabel.sizeToFit()
            releaseDateView.text = movie.releaseDateString
            voteView.text = movie.voteString
            posterImageView.loadLowResImageAndSwapToHiRes(movie.lowResolutionPosterUrl!, hiResImageUrl: movie.hiResolutionPosterUrl!)
            
            let newInfoViewHeight = min(infoView.frame.height, overviewLabel.frame.origin.y + overviewLabel.frame.size.height)
            infoView.frame.size = CGSize(width: infoView.frame.width, height: newInfoViewHeight + 20)
            infoView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
            infoView.layer.cornerRadius = 10.0
            infoView.clipsToBounds = true
            infoView.layoutIfNeeded()
            
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: infoView.frame.origin.y + infoView.frame.height)
            
            scrollView.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
