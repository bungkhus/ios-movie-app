//
//  UIViewController+Additions.swift
//  Soundrenaline
//
//  Created by Wito Chandra on 13/07/16.
//  Copyright © 2016 Suitmedia. All rights reserved.
//

import UIKit
import SBSearchBar

extension UIViewController {
    
    func searchView() -> SBSearchBar {
        let searchBarCustom = SBSearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
        searchBarCustom.placeHolderStr = "Search by title"
        searchBarCustom.lensImage = UIImage(named: "search")
        searchBarCustom.addExtraCancelButton = true
        searchBarCustom.extraCancelButton?.setImage(UIImage(named: "error"), for: .normal)
        searchBarCustom.extraCancelButton?.setTitle("", for: .normal)
        navigationItem.titleView = searchBarCustom

        return searchBarCustom
    }

    func setupTitle(_ title: String? = "title") {
        if let title = title {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
            label.textAlignment = .center
            label.text = title
            label.font = UIFont.systemFont(ofSize: 18)
            navigationItem.titleView = label
        }
    }
    
}
