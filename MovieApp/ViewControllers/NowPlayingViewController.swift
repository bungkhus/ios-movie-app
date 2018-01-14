//
//  NowPlayingViewController.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SVProgressHUD

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let interactor = NowPlayingInteractor(perPage: 20, storeKey: "NowPlaying")
    var refreshed = false
//    var loadOnAppear = false
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    // MARK: OVERRIDE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle("Now Playing")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        tableViewDataSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if loadOnAppear {
//            loadData()
//        }
//        loadOnAppear = true
        
        if !refreshed {
            if interactor.movies.count > 0 {
                collectionView.pullToRefreshView.startAnimatingAndScroll(false)
            } else {
                collectionView.pullToRefreshView.startAnimatingAndScroll(true)
            }
            refresh()
            refreshed = !refreshed
        }
        
    }
    
    // MARK: METHODS
    
    func loadData() {
        interactor.loadKey()
        collectionView.reloadData()
    }
    
    func tableViewDataSetup() {
        collectionView.addPullToRefresh {
            self.refresh()
        }
        
        collectionView.addInfiniteScrolling {
            self.interactor.nextWith(success: {
                self.collectionView.infiniteScrollingView.stopAnimating()
                self.collectionView.showsInfiniteScrolling = self.interactor.hasNext
                self.collectionView.reloadData()
            }, failure: { error in
                print(error.localizedDescription)
                self.collectionView.infiniteScrollingView.stopAnimating()
            })
        }
        collectionView.pullToRefreshView.activityIndicatorViewColor = UIColor.gray
        collectionView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        collectionView.infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        collectionView.showsInfiniteScrolling = false
        
        loadData()
    }
    
    func refresh() {
        self.interactor.refresh(success: {
            self.collectionView.pullToRefreshView.stopAnimating()
            self.collectionView.showsInfiniteScrolling = self.interactor.hasNext
            self.collectionView.reloadData()
            self.collectionView.reloadEmptyDataSet()
        }, failure: { error in
            self.collectionView.reloadEmptyDataSet()
            print(error.localizedDescription)
            self.collectionView.pullToRefreshView.stopAnimating()
        })
    }
    
}

extension NowPlayingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let controller = MovieDetailViewController.instantiate(id: self.interactor.movies[indexPath.row].identifier)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension NowPlayingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        if interactor.movies.count > 0 {
            cell.nowPlaying = interactor.movies[indexPath.row]
        }
        //cell.videoImageView = ""
        return cell
    }
}

// MARK: - EmptyDataSet

extension NowPlayingViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return interactor.movies.count == 0
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = NSAttributedString(string: "Data doesn't exists.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.secondaryTextColor(), NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 14)!])
        return title
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20
    }
}
