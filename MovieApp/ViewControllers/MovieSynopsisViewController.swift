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
    
    var overview: String?
    
    static func instantiate() -> MovieSynopsisViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieSynopsisSID") as! MovieSynopsisViewController
        return controller
    }
    
    func setupView(movie: Movie)  {
        if labelSynopsis != nil {
            labelSynopsis.text = movie.desc
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
     
        if let overview = overview {
            labelSynopsis.text = overview
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let overview = overview {
            labelSynopsis.text = overview
        }
    }

}
