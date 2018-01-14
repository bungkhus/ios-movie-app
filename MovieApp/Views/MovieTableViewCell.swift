//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.cardifyItem()
        imagePoster.cardifyItem()
    }
    
    var popular: Movie? {
        didSet{
            if let movie = popular {
                if let title = movie.title {
                   labelTitle.text = title
                }
                if let overview = movie.desc {
                    labelOverview.text = overview
                }
                labelRating.text = "\(movie.voteAverage)"
                if let photoUrl = movie.posterPath, let url = URL(string: ("\(ApiConfig.posterHomeUrl)\(photoUrl)")) {
                    imagePoster.af_setImage(withURL: url, placeholderImage: UIImage(named: "play-button"), imageTransition: .crossDissolve(0.2))
                } else {
                    imagePoster.image = UIImage(named: "play-button")
                }
            }
        }
    }

}
