//
//  MovieSynopsisViewController.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit

class MovieSynopsisViewController: UIViewController {
    
    @IBOutlet weak var labelSynopsis: UILabel!
    
    func setupView(movie: Movie)  {
        if labelSynopsis != nil {
            labelSynopsis.text = movie.desc
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
