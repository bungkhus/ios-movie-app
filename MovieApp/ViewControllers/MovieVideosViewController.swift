//
//  MovieVideosViewController.swift
//  
//
//  Created by bungkhus on 15/01/18.
//

import UIKit

class MovieVideosViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "VideoTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 4, 0)
        tableView.rowHeight = 210

        // Do any additional setup after loading the view.
    }

}

extension MovieVideosViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        if interactor.casts.count > 5 {
//            return 2
//        }
//        return interactor.casts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.selectionStyle = .none
//        if self.interactor.casts.count > 0 {
//            cell.cast = self.interactor.casts[indexPath.row]
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let controller = MovieDetailViewController.instantiate(id: self.interactor.movies[indexPath.row].identifier)
        //        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
