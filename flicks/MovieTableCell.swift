//
//  MovieCell.swift
//  flicks
//
//  Created by dawei_wang on 9/12/17.
//  Copyright © 2017 dawei_wang. All rights reserved.
//

import UIKit
import AFNetworking

class MovieTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    var movie : Movie! {
        didSet {
            overlayView.backgroundColor = UIColor.rausch()
            titleLabel.text = movie.title
            contentLabel.text = movie.overview
            voteLabel.text = movie.voteString
            if let posterUrl = movie.posterUrl {
                posterImageView.fadeInImageFromUrl(posterUrl, placeholderImage: nil, fadeInDuration: 0.5)
                
                posterImageView.layer.cornerRadius = 5.0
                posterImageView.clipsToBounds = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
