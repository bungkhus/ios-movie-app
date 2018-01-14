//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit
import SVProgressHUD

class MovieDetailViewController: MXSegmentedPagerController {
    
    private let title0 = "Synopsis"
    private let title1 = "Top Billed Cast"
    private let title2 = "Trailers"
    private let interactor = MovieDetailInteractor()
    private let xib = Bundle.main.loadNibNamed("MovieDetailHeader", owner: nil, options: nil)?[0] as! MovieDetailHeader
    
    private var movieId:Int64 = 0
    private var refreshed = false
    
    static func instantiate(id: Int64) -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailSID") as! MovieDetailViewController
        controller.movieId = id
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parallax Header
        setupHeader()
        updateHeader()
        
        // Segmented Control (tab) customization
        // Segmented Control customization
        segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        // will be used
        //        segmentedPager.segmentedControl.backgroundColor = UIColor(hex:0xD91A31)
        segmentedPager.segmentedControl.backgroundColor = UIColor.clear
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.secondaryTextColor(), NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 14)!]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.textColor(), NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 14)!]
        segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor.textColor()
        segmentedPager.segmentedControl.selectionIndicatorHeight = 2
//        segmentedPager.segmentedControl.type = .fixed
        self.segmentedPager.segmentedControl.backgroundColor = UIColor.white
        
        self.segmentedPager.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !refreshed {
            SVProgressHUD.show()
            interactor.refresh(withId: movieId, success: { () -> (Void) in
                if let movie = self.interactor.movie {
//                    MovieSynopsisViewController.instantiate().setupView(movie: movie)
                    self.updateHeader()
                    self.refreshed = true
                    SVProgressHUD.dismiss()
                }
            }) { (error) -> (Void) in
                print(error.localizedDescription)
                SVProgressHUD.showError(withStatus: error.localizedDescription)
                SVProgressHUD.dismiss(withDelay: 2.0)
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("prepare \(segue.identifier)")
        if segue.identifier == "mx_page_0" {
            let controller = segue.destination as! MovieSynopsisViewController
            if let movie = self.interactor.movie {
                controller.setupView(movie: movie)
                self.updateHeader()
                
                if !refreshed {
                    SVProgressHUD.show()
                    interactor.refresh(withId: movieId, success: { () -> (Void) in
                        if let movie = self.interactor.movie {
                            controller.setupView(movie: movie)
                            self.updateHeader()
                            self.refreshed = true
                            SVProgressHUD.dismiss()
                        }
                    }) { (error) -> (Void) in
                        print(error.localizedDescription)
                        SVProgressHUD.showError(withStatus: error.localizedDescription)
                        SVProgressHUD.dismiss(withDelay: 2.0)
                        
                    }
                }
            }
        } else if segue.identifier == "mx_page_2" {
            print("2")
//            let controller = segue.destination as! MovieSynopsisViewController
//            if let movie = self.interactor.movie {
//                controller.setupView(movie: movie)
//                self.updateHeader()
//
//                interactor.refresh(withId: movieId, success: { () -> (Void) in
//                    if let movie = self.interactor.movie {
//                        controller.setupView(movie: movie)
//                        self.updateHeader()
//                    }
//                }) { (error) -> (Void) in
//                    print(error.localizedDescription)
//                    SVProgressHUD.showError(withStatus: error.localizedDescription)
//                    SVProgressHUD.dismiss(withDelay: 2.0)
//
//                }
//            }
        } else {
            print("3")
        }
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return [title0, title1, title2][index];
    }
    
    func setupHeader() {
        self.segmentedPager.bounces = false
        self.segmentedPager.parallaxHeader.view = xib
        self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderMode.topFill
        let height = UIScreen.main.bounds.width / 1.7
        self.segmentedPager.parallaxHeader.height = height
        self.segmentedPager.parallaxHeader.minimumHeight = 0
        
    }
    
    func updateHeader() {
        interactor.loadWith(id: movieId)
        if let movie = interactor.movie {
            xib.movie = movie
        }
    }
    
}
