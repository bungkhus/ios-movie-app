//
//  MovieDetailHeader.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit

class MovieDetailHeader: UIView {

    @IBOutlet weak var imageBackdrop: UIImageView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var lsbelReleaseDate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    @IBOutlet weak var labelGandres: UILabel!
    @IBOutlet var lableRatting: UILabel!
    @IBOutlet var lableVoters: UILabel!
    @IBOutlet var lableOriginalLang: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                if let title = movie.title {
                    labelTitle.text = title
                }
                labelGandres.text = ""
                if let gendres = movie.gendres {
                    labelGandres.text = gendres
                }
                if let lang = movie.originalLanguage {
                    lableOriginalLang.text = lang.uppercased()
                }
                if let date = movie.releaseDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMMM yyyy"
                    lsbelReleaseDate.text = formatter.string(from: date as Date)
                }
                lableVoters.text = "(\(movie.voteCount.format(f: "1.000")) voters)"
                lableRatting.text = "\(movie.voteAverage)"
                
                let hours = movie.runtime / 60
                let minutes = movie.runtime % 60
                labelRuntime.text = "\(hours)h \(minutes)m"
                
                if let photoUrl = movie.backdropPath, let url = URL(string: ("\(ApiConfig.backdropHomeUrl)\(photoUrl)")) {
                    imageBackdrop.af_setImage(withURL: url, placeholderImage: UIImage(named: "play-button"), imageTransition: .crossDissolve(0.2))
                } else {
                    imageBackdrop.image = UIImage(named: "play-button")
                }
                if let photoUrl = movie.posterPath, let url = URL(string: ("\(ApiConfig.posterHomeUrl)\(photoUrl)")) {
                    imagePoster.af_setImage(withURL: url, placeholderImage: UIImage(named: "play-button"), imageTransition: .crossDissolve(0.2))
                } else {
                    imagePoster.image = UIImage(named: "play-button")
                }
            }
        }
    }
    
}

extension Int64 {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}
