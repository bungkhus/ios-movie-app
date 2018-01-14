//
//  CastTableViewCell.swift
//  MovieApp
//
//  Created by bungkhus on 15/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var lableName: UILabel!
    @IBOutlet var lableAs: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var cast: Cast? {
        didSet{
            if let cast = cast {
                if let name = cast.name {
                    lableName.text = name
                }
                if let character = cast.character {
                    lableAs.text = "as \(character)"
                }
                if let photoUrl = cast.profilePath, let url = URL(string: ("\(ApiConfig.posterHomeUrl)\(photoUrl)")) {
                    imageProfile.af_setImage(withURL: url, placeholderImage: UIImage(named: "play-button"), imageTransition: .crossDissolve(0.2))
                } else {
                    imageProfile.image = UIImage(named: "play-button")
                }
            }
        }
    }
    
    

}
