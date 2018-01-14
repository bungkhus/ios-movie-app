//
//  MovieVideosViewController.swift
//  
//
//  Created by bungkhus on 15/01/18.
//

import UIKit
import SVPullToRefresh
import SVProgressHUD
import DZNEmptyDataSet

class MovieVideosViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var refreshed = false
    var movieId: Int64 = 0
    
    let interactor = MovieVideoInteractor(perPage: 100, storeKey: "Video")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0)
        tableView.rowHeight = 250
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !refreshed {
            if interactor.videos.count > 0 {
                tableView.pullToRefreshView.startAnimatingAndScroll(false)
            } else {
                tableView.pullToRefreshView.startAnimatingAndScroll(true)
            }
            refresh()
            refreshed = !refreshed
        }
    }
    
    // MARK: DATA
    
    func loadData() {
        interactor.loadKey()
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.addPullToRefresh {
            self.refresh()
        }
        
        tableView.addInfiniteScrolling {
            self.interactor.nextWith(id: self.movieId, success: {
                self.tableView.infiniteScrollingView.stopAnimating()
                self.tableView.showsInfiniteScrolling = self.interactor.hasNext
                self.tableView.reloadData()
            }, failure: { error in
                self.tableView.infiniteScrollingView.stopAnimating()
            })
        }
        
        tableView.pullToRefreshView.activityIndicatorViewColor = UIColor.gray
        tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        tableView.infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        tableView.showsInfiniteScrolling = false
        
        loadData()
    }
    
    func refresh() {
        interactor.refresh(id: movieId, success: {
            self.tableView.pullToRefreshView.stopAnimating()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.showsInfiniteScrolling = self.interactor.hasNext
            self.tableView.reloadData()
        }, failure: { error in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
            self.tableView.pullToRefreshView.stopAnimating()
            self.tableView.infiniteScrollingView.stopAnimating()
        })
    }

}

extension MovieVideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.selectionStyle = .none
        if interactor.videos.count > 0 {
            cell.video = interactor.videos[indexPath.row]
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
}

extension MovieVideosViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return interactor.videos.count == 0
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = NSAttributedString(string: "Data doesn't exists.", attributes: [NSAttributedStringKey.foregroundColor: UIColor.secondaryTextColor(), NSAttributedStringKey.font: UIFont(name: "Avenir-Medium", size: 14)!])
        return title
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20
    }
    
}
