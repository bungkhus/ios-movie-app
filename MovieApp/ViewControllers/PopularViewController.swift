//
//  PopularViewController.swift
//  MovieApp
//
//  Created by bungkhus on 14/01/18.
//  Copyright © 2018 Bungkhus. All rights reserved.
//

import UIKit
import SVPullToRefresh
import SVProgressHUD
import DZNEmptyDataSet

class PopularViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshed = false
    let interactor = PopularInteractor(perPage: 20, storeKey: "Popular")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle("Popular")

        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0)
        tableView.rowHeight = 100 //UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 124
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !refreshed {
            if interactor.movies.count > 0 {
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
            self.interactor.nextWith(success: {
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
        interactor.refresh(success: {
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

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = .none
        if self.interactor.movies.count > 0 {
            cell.popular = self.interactor.movies[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailSID")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension PopularViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
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
