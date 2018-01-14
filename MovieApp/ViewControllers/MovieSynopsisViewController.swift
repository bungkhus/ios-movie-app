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
    let interactor = MovieDetailInteractor()
    
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
        
        loadData()
    }
    
    func loadData() {
        if let movieId = PreferenceManager.instance.movieId {
            interactor.loadWith(id: movieId)
            if let movie = interactor.movie {
                labelSynopsis.text = movie.desc
            } else {
                refresh(movieId: movieId)
            }
        }
    }
    
    func refresh(movieId: Int64) {
        interactor.refresh(withId: movieId, success: { () -> (Void) in
            if let movie = self.interactor.movie {
                self.labelSynopsis.text = movie.desc
            }
        }) { (error) -> (Void) in
            print(error.localizedDescription)
        }
    }

}
